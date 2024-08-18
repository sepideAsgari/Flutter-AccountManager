import 'dart:convert';

import 'package:acountmanager/Ui/qrCodeScanner.dart';
import 'package:adivery/adivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../Model/bankCard.dart';
import '../Providers/createBankCard.dart';
import '../Utils/customRute.dart';
import '../Utils/myLog.dart';
import '../Utils/staticData.dart';
import '../Utils/themeManager.dart';

class CreateBankCard extends StatelessWidget {
  const CreateBankCard(
      {Key? key, required this.create, this.bankCard, this.index})
      : super(key: key);

  final bool create;
  final BankCard? bankCard;
  final int? index;

  _showInterstitial() {
    AdiveryPlugin.show('ec0cd7e0-cc5f-4802-8bd8-fa7c6b99640d');
  }

  @override
  Widget build(BuildContext context) {
    _showInterstitial();
    if (!create) {
      context.read<CreateBankCardNotifier>().init(bankCard!, index!);
    }
    return WillPopScope(
      onWillPop: () async {
        context.read<CreateBankCardNotifier>().clear();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Consumer<CreateBankCardNotifier>(
              builder: (context, value, child) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                          child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 75),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 60,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: CustomText('Add new bank card',
                                          textSize: 22)),
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const QrCodeScanner(),
                                        ))
                                            .then((value) {
                                          try {
                                            BankCard bankCard =
                                                BankCard.fromJson(json
                                                        .decode(value)
                                                    as Map<String, dynamic>);
                                            Box box = Hive.box<BankCard>(
                                                'bankCardList');
                                            box.add(bankCard);
                                          } catch (e) {
                                            MyLog.e(e.toString());
                                          }
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          'assets/icons/scan.svg')),
                                ],
                              ),
                            ),
                            CustomInput(
                              focusNode: value.getFNName,
                              textEditingController: value.getTECName,
                              hint: 'name *',
                              isPassword: false,
                              horizontalMargin: 0,
                              verticalMargin: 8,
                              icon: 'assets/icons/user.svg',
                              number: false,
                            ),
                            CustomInput(
                              focusNode: value.getFNNumber,
                              textEditingController: value.getTECNumber,
                              hint: 'card number *',
                              isPassword: false,
                              horizontalMargin: 0,
                              verticalMargin: 8,
                              icon: 'assets/icons/credit_card.svg',
                              number: true,
                              length: 16,
                            ),
                            CustomInput(
                              focusNode: value.getFNShaba,
                              textEditingController: value.getTECShaba,
                              hint: 'shaba',
                              isPassword: false,
                              horizontalMargin: 0,
                              verticalMargin: 8,
                              icon: 'assets/icons/heater.svg',
                              number: true,
                              length: 24,
                            ),
                            CustomInput(
                              focusNode: value.getFNPassword,
                              textEditingController: value.getTECPassword,
                              hint: 'password',
                              isPassword: true,
                              horizontalMargin: 0,
                              verticalMargin: 8,
                              icon: 'assets/icons/key.svg',
                              number: true,
                              length: 4,
                            ),
                            CustomInput(
                              focusNode: value.getFNAccountNumber,
                              textEditingController: value.getTECAccountNumber,
                              hint: 'account number',
                              isPassword: false,
                              horizontalMargin: 0,
                              verticalMargin: 8,
                              icon: 'assets/icons/accountNumber.svg',
                              number: true,
                              length: 25,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: CustomInput(
                                        focusNode: value.getFNYears,
                                        textEditingController:
                                            value.getTECYears,
                                        hint: 'year * (2024)',
                                        isPassword: false,
                                        horizontalMargin: 0,
                                        verticalMargin: 8,
                                        icon: 'assets/icons/calendar.svg',
                                        number: true,
                                        length: 4,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: CustomInput(
                                        focusNode: value.getFNMonth,
                                        textEditingController:
                                            value.getTECMonth,
                                        hint: ' month * (02)',
                                        length: 2,
                                        isPassword: false,
                                        horizontalMargin: 0,
                                        verticalMargin: 8,
                                        icon: 'assets/icons/calendar.svg',
                                        number: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomInput(
                              focusNode: value.getFNDescription,
                              textEditingController: value.getTECDescription,
                              hint: 'description',
                              isPassword: false,
                              horizontalMargin: 0,
                              verticalMargin: 8,
                              icon: 'assets/icons/description.svg',
                              number: false,
                            ),
                          ],
                        ),
                      )),
                      Positioned(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            if (value.checkInput()) {
                              Rute.navigateClose(
                                  context, const DesignBankCard());
                            } else {
                              CustomSnackBar().show(context,
                                  'The information is not entered correctly');
                            }
                          },
                          child: Container(
                              height: 55,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColor.blue,
                              ),
                              child:
                                  CustomTextColor('next', CustomColor.white)),
                        ),
                      ))
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DesignBankCard extends StatelessWidget {
  const DesignBankCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CreateBankCardNotifier>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Positioned(
                  child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.8,
                color: CustomColor.blue,
              )),
              Positioned(
                  child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 40,
                                height: 40,
                              ),
                              Expanded(
                                  child: CustomTextColor(
                                      'Add new card', CustomColor.white,
                                      textSize: 22)),
                              InkWell(
                                onTap: () {
                                  Rute.navigateBack(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          CustomColor.gryLight.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child:
                                      const Icon(Icons.arrow_forward_rounded),
                                ),
                              )
                            ],
                          )),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: CustomTextColor(
                            'Custom design for your card', CustomColor.white,
                            textSize: 16),
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.55,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: StaticData.accountColors
                                .elementAt(value.isColorSelected),
                            boxShadow: [
                              BoxShadow(
                                  color: CustomColor.white.withOpacity(.1),
                                  offset: const Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: Column(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        value.mData.favorite =
                                            !value.mData.favorite;
                                        value.notify();
                                      },
                                      child: value.mData.favorite
                                          ? SvgPicture.asset(
                                              'assets/icons/star1.svg',
                                              height: 24,
                                              width: 24,
                                              color: Colors.yellow,
                                            )
                                          : SvgPicture.asset(
                                              'assets/icons/star0.svg',
                                              height: 24,
                                              width: 24,
                                              color: CustomColor.gry,
                                            ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CustomTextColor(
                                      value.getTECName.text, CustomColor.white,
                                      textSize: 16),
                                ),
                                SvgPicture.asset('assets/icons/credit_card.svg',
                                    width: 24, height: 24)
                              ],
                            )),
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              child: CustomTextColor(
                                split4Number(value.getTECNumber.text,
                                    value.mData.numberVisibility),
                                CustomColor.white,
                                textSize: 25,
                              ),
                            )),
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerRight,
                                  child: CustomTextColor(
                                      '${value.getTECYears.text}/${value.getTECMonth.text}',
                                      CustomColor.white,
                                      textSize: 16),
                                ))
                              ],
                            )),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 8),
                        alignment: Alignment.centerRight,
                        child: const CustomText('select color', textSize: 18),
                      ),
                      SizedBox(
                        height: 55,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemCount: StaticData.accountColors.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InkWell(
                                onTap: () {
                                  value.setColorSelected(index);
                                },
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: StaticData.accountColors
                                        .elementAt(index),
                                  ),
                                  child: value.isColorSelected == index
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: CustomColor.white),
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: switchItem(
                          !value.mData.numberVisibility,
                          'Hide card number',
                          value.mData.numberVisibility
                              ? 'assets/icons/show.svg'
                              : 'assets/icons/hidden.svg',
                          (bool b) {
                            value.setVisible(!b);
                          },
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          if (value.createAccount()) {
                            Rute.navigateBack(context);
                          }
                        },
                        child: Container(
                            height: 55,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.blue,
                            ),
                            child: CustomTextColor('add', CustomColor.white)),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          );
        },
      ),
    );
  }

  String split4Number(String number, bool visible) {
    String num = '';
    if (visible) {
      for (int i = 0; i < 16; i += 4) {
        num += number.substring(i, i + 4);
        num += '  ';
      }
    } else {
      num += '****  ****  ****  ';
      num += number.substring(12);
    }
    return num;
  }

  Widget switchItem(bool s, String text, String icon, OnCheck onCheck) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(right: 10),
            decoration: ShapeDecoration(
                color: CustomColor.gry.withOpacity(.1),
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)))),
            child: SvgPicture.asset(icon, color: CustomColor.blue),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: CustomText(text, textSize: 18),
          )),
          CustomSwitch(
            isCheck: s,
            onSwitchChanged: (b) {
              onCheck.call(b);
            },
          ),
        ],
      ),
    );
  }
}
