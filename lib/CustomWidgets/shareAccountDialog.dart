import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Model/account.dart';
import '../Model/bankCard.dart';
import '../Utils/themeManager.dart';
import 'customWidgets.dart';

class ShareAccountDialog {
  showAccount(BuildContext context, Account account) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    double w = (MediaQuery.of(context).size.width);
    String jsonData = json.encode(account.toMap());
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding:
                              EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          child: CustomText('اشتراک گذاری حساب')),
                    ),
                    Container(
                      width: w - 64,
                      height: w - 64,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColor.white.withOpacity(.9)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextColor(
                              'کد QR را اسکن کنید', CustomColor.textColor,
                              textSize: 16, textDirection: TextDirection.rtl),
                          Expanded(
                            child: Center(
                              child: QrImageView(
                                data: jsonData,
                                version: QrVersions.auto,
                                size: w / 2,
                                gapless: false,
                              ),
                            ),
                          ),
                          CustomTextColor(
                              'مراقب این QR کد باشید هر فردی با اسکن کردن آن میتواند به اطلاعات شما پی ببرد و از آن استفاده کند.',
                              CustomColor.textColor,
                              textSize: 14,
                              textDirection: TextDirection.rtl)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  showBankCard(BuildContext context, BankCard bankCard) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    double w = (MediaQuery.of(context).size.width);
    String jsonData = json.encode(bankCard.toMap());
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding:
                              EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          child: CustomText('اشتراک گذاری کارت بانکی')),
                    ),
                    Container(
                      width: w - 64,
                      height: w - 64,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColor.white.withOpacity(.9)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextColor(
                              'کد QR را اسکن کنید', CustomColor.textColor,
                              textSize: 16, textDirection: TextDirection.rtl),
                          Expanded(
                            child: Center(
                              child: QrImageView(
                                data: jsonData,
                                version: QrVersions.auto,
                                size: w / 2,
                                gapless: false,
                              ),
                            ),
                          ),
                          CustomTextColor(
                            'مراقب این QR کد باشید هر فردی با اسکن کردن آن میتواند به اطلاعات شما پی ببرد و از آن استفاده کند.',
                            CustomColor.textColor,
                            textSize: 14,
                            textDirection: TextDirection.rtl,
                          )
                        ],
                      ),
                    )
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
