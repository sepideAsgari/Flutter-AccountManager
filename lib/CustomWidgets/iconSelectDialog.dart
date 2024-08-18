import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Utils/customRute.dart';
import '../Utils/staticData.dart';
import '../Utils/themeManager.dart';

typedef OnSelectIcon = Function(String icon);

class IconSelectDialog {

  show(BuildContext context, OnSelectIcon onSelectIcon){
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    double w = (MediaQuery.of(context).size.width - 48) / 4;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/bottom_s.svg',
                color: CustomColor.gry,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 20),
                height: w * 4,
                decoration: BoxDecoration(
                    color: dark ? CustomColor.bgBottomSheet : CustomColor.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                  shrinkWrap: true,
                  itemCount: StaticData.accountIcons.length,
                  itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onSelectIcon.call(StaticData.accountIcons.elementAt(index));
                      Rute.navigateBack(context);
                    },
                    child: Container(
                      width: w,
                      height: w,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        StaticData.accountIcons.elementAt(index),
                        height: w/2.5,
                        width: w/2.5,
                      ),
                    ),
                  );
                },)
              )
            ],
          ),
        );
      },
    );
  }
}