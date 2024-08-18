import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/themeManager.dart';
import 'customWidgets.dart';


class CustomSnackBar {

  show(BuildContext context,String text){
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    SnackBar snackBar = SnackBar(
      content: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: dark ? CustomColor.bgBottomSheet : CustomColor.white,
            borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: CustomColor.gry.withOpacity(.3),
              blurRadius: 3,
              spreadRadius: 0,
              offset: const Offset(0,1)
            )
          ]
        ),
        child: Row(
          children: [
            Expanded(child: Align(alignment: Alignment.centerRight,child: CustomTextColor(text, dark ? CustomColor.white : CustomColor.bgColor, textSize: 18,))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset('assets/icons/copy.svg' ,width: 24,height: 24, color: CustomColor.blue,),
            )
          ],
        ),
      ),
      padding: const EdgeInsets.only(left: 16 ,bottom: 16, right: 16),
      dismissDirection: DismissDirection.down,
      backgroundColor: Colors.transparent,
      duration:  const Duration(seconds: 2),
      elevation: 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}