

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../Model/bankCard.dart';

class CreateBankCardNotifier extends ChangeNotifier {

  BankCard bankCard = BankCard('', '', '', 0, '', 0, false, '', '', false);

  BankCard get mData => bankCard;

  int index = -1;
  bool create = true;

  int colorSelected = 0;

  int get isColorSelected => colorSelected;

  setColorSelected(int i){
    if(colorSelected != i){
      colorSelected = i;
      bankCard.color = colorSelected;
      notify();
    }
  }


  TextEditingController tECName = TextEditingController();
  TextEditingController tECNumber = TextEditingController();
  TextEditingController tECShaba = TextEditingController();
  TextEditingController tECPassword = TextEditingController();
  TextEditingController tECAccountNumber = TextEditingController();
  TextEditingController tECMonth = TextEditingController();
  TextEditingController tECYears = TextEditingController();
  TextEditingController tECDescription = TextEditingController();

  FocusNode fNName = FocusNode();
  FocusNode fNNumber= FocusNode();
  FocusNode fNShaba = FocusNode();
  FocusNode fNPassword = FocusNode();
  FocusNode fNAccountNumber = FocusNode();
  FocusNode fNMonth = FocusNode();
  FocusNode fNYears = FocusNode();
  FocusNode fNDescription = FocusNode();

  TextEditingController get getTECName => tECName;
  TextEditingController get getTECNumber => tECNumber;
  TextEditingController get getTECShaba => tECShaba;
  TextEditingController get getTECPassword => tECPassword;
  TextEditingController get getTECAccountNumber => tECAccountNumber;
  TextEditingController get getTECMonth => tECMonth;
  TextEditingController get getTECYears => tECYears;
  TextEditingController get getTECDescription => tECDescription;

  FocusNode get getFNName => fNName;
  FocusNode get getFNNumber => fNNumber;
  FocusNode get getFNPassword => fNPassword;
  FocusNode get getFNDescription => fNDescription;
  FocusNode get getFNAccountNumber => fNAccountNumber;
  FocusNode get getFNMonth => fNMonth;
  FocusNode get getFNYears => fNYears;
  FocusNode get getFNShaba => fNShaba;

  CreateBankCardNotifier(){
    tECName.addListener(() {
      notify();
    });
    tECNumber.addListener(() {
      notify();
    });
    tECShaba.addListener(() {
      notify();
    });
    tECPassword.addListener(() {
      notify();
    });
    tECAccountNumber.addListener(() {
      notify();
    });
    tECMonth.addListener(() {
      notify();
    });
    tECYears.addListener(() {
      notify();
    });
    tECDescription.addListener(() {
      notify();
    });
  }

  clear(){
    index = -1;
    create = true;
    tECName.text = '';
    tECShaba.text = '';
    tECDescription.text = '';
    tECPassword.text = '';
    tECAccountNumber.text = '';
    tECMonth.text = '';
    tECYears.text = '';
    tECNumber.text = '';
    bankCard = BankCard('', '', '', 0, '', 0, false, '', '', false);
  }

  setVisible(bool b){
    bankCard.numberVisibility = b;
    notify();
  }

  notify(){
    Future.delayed(Duration.zero,() {
      notifyListeners();
    },);
  }

  init(BankCard bankCard,int index){
    this.index = index;
    create = false;
    this.bankCard = bankCard;
    tECName.text = bankCard.name;
    tECShaba.text = bankCard.shaba.toString();
    tECDescription.text = bankCard.description;
    tECPassword.text = bankCard.password.toString();
    tECAccountNumber.text = bankCard.accountNumber.toString();
    tECMonth.text = bankCard.date.split('/')[1];
    tECYears.text = bankCard.date.split('/')[0];
    tECNumber.text = bankCard.number.toString();
    colorSelected = bankCard.color;
    notify();
  }

  bool createAccount(){

    String name = tECName.text;
    String shaba = tECShaba.text;
    String number = tECNumber.text;
    String password = tECPassword.text;
    String accountNumber = tECAccountNumber.text;
    String month = tECMonth.text;
    String years = tECYears.text;
    String description = tECDescription.text;


    if(checkInput()){
      bankCard.name = name;
      if(password.isNotEmpty){
        bankCard.password = int.parse(password);
      }
      if(shaba.isNotEmpty){
        bankCard.shaba = shaba;
      }
      if(description.isNotEmpty){
        bankCard.description = description;
      }
      if(accountNumber.isNotEmpty){
        bankCard.accountNumber = accountNumber;
      }
      bankCard.number = number;
      bankCard.date = '$years/$month';
      Box box = Hive.box<BankCard>('bankCardList');
      if(create){
        box.add(bankCard);
      }else{
        box.putAt(index,bankCard);
      }
      clear();
      return true;
    }else{
      return false;
    }

  }

  bool checkInput(){
    String name = tECName.text;
    String number = tECNumber.text;
    String month = tECMonth.text;
    String years = tECYears.text;

    bool check = true;

    if(name.isEmpty){
      check = false;
    }
    if(number.isEmpty || number.length < 16){
      check = false;
    }
    if(years.isEmpty || month.isEmpty){
      check = false;
    }

    return check;
  }

}