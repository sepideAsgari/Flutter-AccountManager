import 'dart:async';

import 'package:acountmanager/Providers/settingProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import '../Ui/passwordScreen.dart';
import '../Utils/myLog.dart';

class PasswordChangeNotifier extends ChangeNotifier {
  String passwordHelp = 'ورود';
  String password = '';
  String checkPassword = '';
  bool canCheckPassword = false;
  bool checkOldPassword = false;

  String get getPassword => password;
  String get getPasswordHelp => passwordHelp;

  late LoginState loginState;
  late BuildContext context;

  PasswordScreenMode passwordScreenMode = PasswordScreenMode.loginPassword;

  LocalAuthentication localAuthentication = LocalAuthentication();
  bool canCheckBiometric = false;

  Future<bool> checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      MyLog.e(e.message.toString());
    }
    return canCheckBiometric;
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await localAuthentication.authenticate(
          localizedReason: 'fingerprint login',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: false, useErrorDialogs: true));
    } on PlatformException catch (e) {
      MyLog.e(e.message.toString());
    }
    return authenticated;
  }

  static initBox() async {
    if (!Hive.isBoxOpen('userPassword')) {
      await Hive.openBox('userPassword');
    }
  }

  closeBox() {
    Hive.box('userPassword').close();
  }

  init(BuildContext context, LoginState loginState,
      PasswordScreenMode passwordScreenMode) {
    initBox();
    this.passwordScreenMode = passwordScreenMode;
    this.loginState = loginState;
    this.context = context;
    if (passwordScreenMode == PasswordScreenMode.loginPassword) {
      if (SettingNotifier().isFingerPrintAuth) {
        checkBiometric().then((value) {
          canCheckBiometric = value;
          if (value) {
            authenticate().then((value) {
              if (value) {
                loginState.login(context);
              } else {
                loginState.errorBiometric(context);
              }
            });
          }
        });
      }
    }

    switch (passwordScreenMode) {
      case PasswordScreenMode.createPassword:
        passwordHelp = 'enter your password';
        break;
      case PasswordScreenMode.changePassword:
        passwordHelp = 'enter your current password';
        break;
      case PasswordScreenMode.loginPassword:
        passwordHelp = 'enter your password';
        break;
    }
  }

  biometricAuthenticate() {
    if (canCheckBiometric) {
      authenticate().then((value) {
        loginState.login(context);
      });
    } else {
      loginState.errorBiometric(context);
    }
  }

  notify() {
    Future.delayed(
      Duration.zero,
      () {
        notifyListeners();
      },
    );
  }

  reset() {
    password = '';
    checkPassword = '';
    notify();
  }

  addCode(String code) {
    if (password.length < 4) {
      if (password.length == 3) {
        password += code;
        switch (passwordScreenMode) {
          case PasswordScreenMode.createPassword:
            if (canCheckPassword) {
              if (password == checkPassword) {
                savePasswordLogin(password);
              } else {
                password = '';
                notify();
              }
            } else {
              canCheckPassword = true;
              checkPassword = password;
              password = '';
              passwordHelp = 're-enter your password';
              notify();
            }
            break;
          case PasswordScreenMode.changePassword:
            if (checkOldPassword) {
              if (canCheckPassword) {
                if (password == checkPassword) {
                  changePasswordLogin(password);
                } else {
                  loginState.error(context);
                }
              } else {
                canCheckPassword = true;
                checkPassword = password;
                password = '';
                passwordHelp = 're-enter your new password';
                notify();
              }
            } else {
              String userPassword =
                  Hive.box('userPassword').get('password', defaultValue: '');
              if (userPassword == password) {
                checkOldPassword = true;
                passwordHelp = 'enter your new password';
                password = '';
              } else {
                loginState.error(context);
              }
            }
            break;
          case PasswordScreenMode.loginPassword:
            checkPasswordLogin(password);
            break;
        }
      } else {
        password += code;
      }
    }
    notify();
  }

  changePasswordLogin(String password) {
    Hive.box('userPassword').put('password', password);
    loginState.change(context);
    closeBox();
  }

  savePasswordLogin(String password) {
    reset();
    Hive.box('userPassword').put('password', password);
    Hive.box('userPassword').put('login', true);
    loginState.login(context);
    closeBox();
  }

  checkPasswordLogin(String password) {
    String userPassword =
        Hive.box('userPassword').get('password', defaultValue: '');
    if (password == userPassword) {
      reset();
      closeBox();
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          loginState.login(context);
        },
      );
    } else {
      reset();
      loginState.error(context);
    }
  }
}

abstract class LoginState {
  login(BuildContext context);
  error(BuildContext context);
  errorBiometric(BuildContext context);
  change(BuildContext context);
}
