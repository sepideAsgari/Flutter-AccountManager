import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Utils/themeManager.dart';

class PasswordGeneratorNotifier extends ChangeNotifier {

  String password = '';
  String passwordCopy = '';

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  bool number = false;
  bool letters = true;
  bool capitalLetters = false;
  bool character = false;

  int passLength = 16;

  Color colorStrength = Colors.red;

  List<String> numberList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List<String> lettersList = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];

  List<String> capitalLettersList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  List<String> characterList = ['!', '@', '#', '%', '^', '\\', '\$', '&'];

  bool get isNumber => number;

  bool get isLetters => letters;

  bool get isCapitalLetters => capitalLetters;

  bool get isCharacter => character;

  String get getPassword => password;

  String get getPasswordCopy => passwordCopy;

  int get getPassLength => passLength;

  Color get getColorStrength => colorStrength;


  PasswordGeneratorNotifier(){
    passwordGenerate();
  }

  setNumber(bool b) {
    if(!b){
      if(letters || capitalLetters){
        number = b;
        passwordGenerate();
      }
    }else{
      number = b;
      passwordGenerate();
    }
  }

  setLetters(bool b) {
    if(!b){
      if(number || capitalLetters){
        letters = b;
        passwordGenerate();
      }
    }else{
      letters = b;
      passwordGenerate();
    }

  }

  setCapitalLetters(bool b) {
    if(!b){
      if(number || letters){
        capitalLetters = b;
        passwordGenerate();
      }
    }else{
      capitalLetters = b;
      passwordGenerate();
    }
  }

  setCharacter(bool b) {
    if(!b){
      if(capitalLetters || letters || number){
        character = b;
        passwordGenerate();
      }
    }else{
      character = b;
      passwordGenerate();
    }
  }

  setPassLength(int length){
    passLength = length;
    passwordGenerate();
  }

  notify() {
    Future.delayed(
      Duration.zero,
      () {
        notifyListeners();
      },
    );
  }

  passwordGenerate(){
    List<String> activeCharacter = [];
    password = '';

    if(number){
      activeCharacter.addAll(numberList);
    }

    if(letters){
      activeCharacter.addAll(lettersList);
    }

    if(capitalLetters){
      activeCharacter.addAll(capitalLettersList);
    }

    if(character){
      activeCharacter.addAll(characterList);
    }

    Random random = Random();

    for(int i = 0; i<= passLength; i++){
       password+= activeCharacter.elementAt(random.nextInt(activeCharacter.length));
    }

    _checkPassword(password);

  }

  void _checkPassword(String value) {
   String _password = value.trim();
    if (_password.length < 8) {
      colorStrength = Colors.yellow;
    } else {
      if (!passValid.hasMatch(_password)) {
        colorStrength = Colors.green;
      } else {
        colorStrength = CustomColor.blue;
      }
    }
    notify();
  }

}
