import 'package:flutter/material.dart';

import '../Utils/staticData.dart';
import '../Utils/themeManager.dart';
import 'customWidgets.dart';

class ColorSelected extends StatelessWidget {
  const ColorSelected({Key? key ,required this.selected , required this.onClickSelected}) : super(key: key);

  final OnClickSelected onClickSelected;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: StaticData.accountColors.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: () {
              onClickSelected.call(index);
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: StaticData.accountColors.elementAt(index),
                borderRadius: BorderRadius.circular(15),
              ),
              child: selected == index ? Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: CustomColor.white,
                  borderRadius: BorderRadius.circular(10)
                ),
              ) : Container()
            ),
          ),
        );
      },),
    );
  }
}
