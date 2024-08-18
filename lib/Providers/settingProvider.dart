

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingNotifier extends ChangeNotifier {


  static init() async {
    await Hive.openBox('settings');
  }

  static bool getCatching(String name){
    return Hive.box('settings').get(name,defaultValue: false);
  }

  static setCatching(String name , bool b){
    Hive.box('settings').put(name , b);
  }

  bool fingerPrintAuth = getCatching('fingerPrintAuth');
  bool disableScreenShot = getCatching('disableScreenShot');
  bool accountProVersion = getCatching('accountProVersion');

  bool get isFingerPrintAuth => fingerPrintAuth;
  bool get isDisableScreenShot => disableScreenShot;
  bool get isAccountProVersion => accountProVersion;

  setFingerPrintAuth(bool b){
    fingerPrintAuth = b;
    setCatching('fingerPrintAuth',b);
    notify();
  }

  setDisableScreenShot(bool b){
    disableScreenShot = b;
    setCatching('disableScreenShot',b);
    notify();
  }

  setAccountProVersion(){
    accountProVersion = true;
    setCatching('accountProVersion', true);
    notify();
  }

  notify(){
    Future.delayed(Duration.zero ,() {
      notifyListeners();
    },);
  }

}