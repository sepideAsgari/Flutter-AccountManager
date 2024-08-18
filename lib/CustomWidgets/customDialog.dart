import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/backUp.dart';
import '../Utils/customRute.dart';
import '../Utils/themeManager.dart';
import 'customSnackbar.dart';
import 'customWidgets.dart';

class CustomDialog {
  showCheckDialog(BuildContext context, String text, OnClick onClick) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.4,
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: dark ? CustomColor.bgBottomSheet : CustomColor.white,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Expanded(
                      child: CustomText(
                    text,
                    textSize: 18,
                  )),
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                onClick.call();
                              },
                              child: const CustomTextColor(
                                'delete',
                                Colors.red,
                                textSize: 20,
                              ))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                Rute.navigateBack(context);
                              },
                              child: const CustomText(
                                'cancel',
                                textSize: 20,
                              )))
                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showBackUpDialog(BuildContext context, bool loadBackUp) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
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
                decoration: BoxDecoration(
                    color: dark ? CustomColor.bgBottomSheet : CustomColor.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 8, bottom: 8),
                          child: CustomText(
                            loadBackUp ? 'select backup file' : 'backup all',
                            textDirection: TextDirection.rtl,
                          )),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 8, bottom: 8),
                          child: CustomTextColor(
                              loadBackUp
                                  ? 'selecte backup file'
                                  : 'With this, all your accounts and cards will be saved in a file in the location you have chosen',
                              CustomColor.gry,
                              textSize: 16,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl)),
                    ),
                    InkWell(
                      onTap: () {
                        if (loadBackUp) {
                          BackUp.loadBackUp(
                            () {
                              Rute.navigateBack(context);
                              CustomSnackBar()
                                  .show(context, 'information added');
                            },
                            () {
                              Rute.navigateBack(context);
                              CustomSnackBar()
                                  .show(context, 'Error reading information');
                            },
                          );
                        } else {
                          BackUp.backUp(() {
                            Rute.navigateBack(context);
                            CustomSnackBar().show(context, 'backup done');
                          }, () {
                            Rute.navigateBack(context);
                            CustomSnackBar().show(context, 'backup problem');
                          });
                        }
                      },
                      child: Container(
                          height: 55,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColor.blue,
                          ),
                          child: CustomTextColor(
                              !loadBackUp ? 'start' : 'chose file',
                              CustomColor.white)),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
