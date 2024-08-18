import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../Model/account.dart';

class CreateAccountNotifier extends ChangeNotifier {

  Account account = Account('', '', '', '', '', '', 0 , '', false);

  Account get getAccount => account;

  int index = -1;
  bool create = true;

  TextEditingController tECName = TextEditingController();
  TextEditingController tECUsername = TextEditingController();
  TextEditingController tECPassword = TextEditingController();
  TextEditingController tECDescription = TextEditingController();
  TextEditingController tECWebSite = TextEditingController();
  FocusNode fNName = FocusNode();
  FocusNode fNUsername= FocusNode();
  FocusNode fNPassword = FocusNode();
  FocusNode fNDescription = FocusNode();
  FocusNode fNWebSite = FocusNode();


  TextEditingController get getTECName => tECName;
  TextEditingController get getTECUsername => tECUsername;
  TextEditingController get getTECPassword => tECPassword;
  TextEditingController get getTECDescription => tECDescription;
  TextEditingController get getTECWebSite => tECWebSite;
  FocusNode get getFNName => fNName;
  FocusNode get getFNUsername => fNUsername;
  FocusNode get getFNPassword => fNPassword;
  FocusNode get getFNDescription => fNDescription;
  FocusNode get getFNWebSite => fNWebSite;


  CreateAccountNotifier(){
    fNName.addListener(() {
      notify();
    });
    fNUsername.addListener(() {
      notify();
    });
    fNPassword.addListener(() {
      notify();
    });
    fNDescription.addListener(() {
      notify();
    });
    fNWebSite.addListener(() {
      notify();
    });
  }


  clear(){
    index = -1;
    create = true;
    tECName.text = '';
    tECWebSite.text = '';
    tECDescription.text = '';
    tECPassword.text = '';
    tECUsername.text = '';
    account = Account('', '', '', '', '', '', 0 , '', false);
  }


  setIcon(String icon){
    account.icon = icon;
    notify();
  }

  setColorSelected(int i){
    account.color = i;
    notify();
  }

  notify(){
    Future.delayed(Duration.zero,() {
      notifyListeners();
    },);
  }

  init(Account account,int index){
    this.index = index;
    create = false;
    this.account = account;
    tECUsername.text = account.username;
    tECPassword.text = account.password;
    tECDescription.text = account.description;
    tECWebSite.text = account.website;
    tECName.text = account.name;
    notify();
  }

  bool createAccount(){

    String name = tECName.text;
    String username = tECUsername.text;
    String password = tECPassword.text;
    String description = tECDescription.text;
    String website = tECWebSite.text;

    if(checkInput()){
      account.name = name;
      account.password = password;
      account.username = username;
      account.description = description;
      account.website = website;
      Box box = Hive.box<Account>('accountList');
      if(create){
        account.date = DateTime.now().toString();
        box.add(account);
      }else{
        box.putAt(index,account);
      }
      clear();
      return true;
    }else{
      return false;
    }

  }

  bool checkInput(){
    String name = tECName.text;
    String username = tECUsername.text;
    String password = tECPassword.text;

    bool check = true;

    if(name.isEmpty){
      check = false;
    }
    if(username.isEmpty){
      check = false;
    }
    if(password.isEmpty){
      check = false;
    }

    return check;
  }

}