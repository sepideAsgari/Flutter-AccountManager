import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../Providers/passwordProvider.dart';
import '../Providers/settingProvider.dart';
import '../Utils/customRute.dart';
import '../Utils/myLog.dart';
import '../Utils/themeManager.dart';
import 'homeUi.dart';

enum PasswordScreenMode { createPassword, changePassword, loginPassword }

class PasswordScreen extends StatelessWidget implements LoginState {
  const PasswordScreen({Key? key, required this.passwordScreenMode})
      : super(key: key);

  final PasswordScreenMode passwordScreenMode;

  @override
  Widget build(BuildContext context) {
    MyLog.e(passwordScreenMode.name.toString());
    double h = ((MediaQuery.of(context).size.height / 2) / 4) - 30;
    context.read<PasswordChangeNotifier>().init(context, this, passwordScreenMode);
    return Scaffold(body: SafeArea(
      child: Consumer<PasswordChangeNotifier>(
        builder: (context, value, child) {
          String pass = '';
          for(int i =0 ; i < value.getPassword.length; i++){
            pass += '•';
          }
          return Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SvgPicture.asset('assets/icons/lock.svg',
                        width: 50, height: 50, color: CustomColor.gry),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: CustomText('login', textSize: 40),
                    ),
                    CustomText(value.getPasswordHelp ,textSize: 16),
                    Expanded(flex: 2,child:  Container(
                      alignment: Alignment.center,
                      child: CustomText(pass,textSize: 50),),)
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
                child: Column(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            child: buttonNumber(
                          '1',
                          h,
                          () {
                            value.addCode('1');
                          },
                        )),
                        Expanded(
                            child: buttonNumber(
                          '2',
                          h,
                          () {
                            value.addCode('2');
                          },
                        )),
                        Expanded(
                            child: buttonNumber(
                          '3',
                          h,
                          () {
                            value.addCode('3');
                          },
                        )),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            child: buttonNumber(
                          '4',
                          h,
                          () {
                            value.addCode('4');
                          },
                        )),
                        Expanded(
                            child: buttonNumber(
                          '5',
                          h,
                          () {
                            value.addCode('5');
                          },
                        )),
                        Expanded(
                            child: buttonNumber(
                          '6',
                          h,
                          () {
                            value.addCode('6');
                          },
                        )),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            child: buttonNumber(
                          '7',
                          h,
                          () {
                            value.addCode('7');
                          },
                        )),
                        Expanded(
                            child: buttonNumber(
                          '8',
                          h,
                          () {
                            value.addCode('8');
                          },
                        )),
                        Expanded(
                            child: buttonNumber(
                          '9',
                          h,
                          () {
                            value.addCode('9');
                          },
                        )),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            child: passwordScreenMode == PasswordScreenMode.loginPassword ? SettingNotifier().isFingerPrintAuth ? buttonIcon(
                          'assets/icons/fingerprint.svg',
                          h,
                          () {
                            value.biometricAuthenticate();
                          },
                        ) : Container() : Container()),
                        Expanded(
                            child: buttonNumber(
                          '0',
                          h,
                          () {
                            value.addCode('0');
                          },
                        )),
                        Expanded(
                            child: buttonIcon(
                          'assets/icons/edit.svg',
                          h,
                          () {
                            value.reset();
                          },
                        )),
                      ],
                    )),
                  ],
                ),
              ))
            ],
          );
        },
      ),
    ));
  }

  Widget buttonNumber(String text, double h, OnClick onClick) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(h / 2),
        onTap: onClick,
        child: Container(
          width: h,
          height: h,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 3),
          child: CustomText(text, textSize: 30),
        ),
      ),
    );
  }

  Widget buttonIcon(String icon, double h, OnClick onClick) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(h / 2),
        onTap: onClick,
        child: Container(
          width: h,
          height: h,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            icon,
            color: CustomColor.gry,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }

  @override
  change(context) {
    Rute.navigateBack(context);
  }

  @override
  error(context) {
    CustomSnackBar().show(context, 'password is wrong');
  }

  @override
  errorBiometric(context) {

  }

  @override
  login(context) {
    switch(passwordScreenMode){
      case PasswordScreenMode.createPassword:
        Rute.navigateClose(context, HomeUI());
        break;
      case PasswordScreenMode.changePassword:
        Rute.navigateBack(context);
        break;
      case PasswordScreenMode.loginPassword:
        Rute.navigateClose(context, HomeUI());
        break;
    }
  }
}
