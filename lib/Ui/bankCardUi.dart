

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../CustomWidgets/customDialog.dart';
import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../CustomWidgets/shareAccountDialog.dart';
import '../Model/bankCard.dart';
import '../Utils/customRute.dart';
import '../Utils/staticData.dart';
import '../Utils/themeManager.dart';
import 'makeBankCard.dart';

class BankCardUi extends StatelessWidget {
  const BankCardUi({Key? key, required this.box, required this.index}) : super(key: key);

  final Box box;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ValueListenableBuilder<Box>(
            valueListenable: box.listenable(),
            builder: (context, value, child) {
              BankCard bankCard = value.getAt(index);
              return Column(
                children: [
                  SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              ShareAccountDialog().showBankCard(context, bankCard);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: CustomColor.gryLight.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(Icons.share),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Rute.navigateBack(context);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: CustomColor.gryLight.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(Icons.arrow_forward_rounded),
                            ),
                          )
                        ],
                      )),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: bankCard.number.toString()));
                      CustomSnackBar().show(context, 'card number copy done');
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.55,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: StaticData.accountColors
                              .elementAt(bankCard.color),
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
                                          bankCard.favorite = !bankCard.favorite;
                                          value.putAt(index, bankCard);
                                        },
                                        child: bankCard.favorite
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
                                        bankCard.name, CustomColor.white,
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
                                  split4Number(bankCard.number,
                                      bankCard.numberVisibility),
                                  CustomColor.white,
                                  textSize: 25,
                                ),
                              )),

                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(child: bankCard.password.toString().isNotEmpty ? Container(
                                    alignment: Alignment.centerLeft,
                                    child: CustomTextColor(
                                        'username : ${bankCard.password}',
                                        CustomColor.white,
                                        textSize: 16),
                                  ) : Container()),
                                  Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: CustomTextColor(
                                            '${bankCard.date.split('/')[0]}/${bankCard.date.split('/')[1]}',
                                            CustomColor.white,
                                            textSize: 16),
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  bankCard.shaba.isNotEmpty ? Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                    alignment: Alignment.center,
                    height: 70,
                    decoration: BoxDecoration(
                      color: CustomColor.gryLight.withOpacity(.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: bankCard.shaba));
                              CustomSnackBar()
                                  .show(context, 'Shaba number copy done');
                            },
                            child: SvgPicture.asset(
                              'assets/icons/copy.svg',
                              width: 24,
                              height: 24,
                              color: CustomColor.gry.withOpacity(.7),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomTextColor(
                                      'shaba number', CustomColor.gry.withOpacity(.9),
                                      textSize: 14),
                                ),
                                Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomText(bankCard.shaba, textSize: 18),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ) : Container(),
                  bankCard.accountNumber.isNotEmpty ? Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                    alignment: Alignment.center,
                    height: 70,
                    decoration: BoxDecoration(
                      color: CustomColor.gryLight.withOpacity(.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: bankCard.accountNumber));
                              CustomSnackBar()
                                  .show(context, 'account number copy done');
                            },
                            child: SvgPicture.asset(
                              'assets/icons/copy.svg',
                              width: 24,
                              height: 24,
                              color: CustomColor.gry.withOpacity(.7),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomTextColor(
                                      'account number', CustomColor.gry.withOpacity(.9),
                                      textSize: 14),
                                ),
                                Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomText(bankCard.accountNumber, textSize: 18),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ) : Container(),
                  bankCard.description.isNotEmpty ? Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                    alignment: Alignment.center,
                    height: 70,
                    decoration: BoxDecoration(
                      color: CustomColor.gryLight.withOpacity(.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextColor(
                              'description', CustomColor.gry.withOpacity(.9),
                              textSize: 14),
                        ),
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CustomText(bankCard.description, textSize: 18),
                            ))
                      ],
                    ),
                  ) : Container(),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Rute.navigate(
                          context,
                          CreateBankCard(
                            create: false,
                            bankCard: bankCard,
                            index: index,
                          ));
                    },
                    child: Container(
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColor.blue,
                        ),
                        child:
                        CustomTextColor('edit account', CustomColor.white)),
                  ),
                  Container(
                      height: 55,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            CustomDialog().showCheckDialog(context, 'Do you want delete this card?', (){
                              CustomSnackBar().show(context,'Card ${bankCard.name} deleted');
                              StaticData.deleteAccount(box, index);
                              Rute.navigateBack(context);
                              Rute.navigateBack(context);
                            });
                          },
                          child:
                          const CustomTextColor('delete card', Colors.red))),
                ],
              );
            },
          ),
        ),
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

}
