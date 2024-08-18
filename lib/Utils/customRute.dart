import 'package:flutter/material.dart';

class Rute {

  static navigate(BuildContext context,Widget widget){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget,));
  }

  static navigateClose(BuildContext context,Widget widget){
    navigateBack(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget,));
  }

  static navigateBack(BuildContext context){
    Navigator.of(context).pop();
  }

}