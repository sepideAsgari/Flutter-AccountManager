import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../CustomWidgets/customDialog.dart';
import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../Model/passHistory.dart';
import '../Providers/passwordGeneratorProvider.dart';
import '../Utils/customRute.dart';
import '../Utils/themeManager.dart';

class PasswordGenerator extends StatelessWidget {
  const PasswordGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Consumer<PasswordGeneratorNotifier>(
      builder: (context, value, child) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              child: const CustomText('Generate password', textSize: 22),
            ),
            Container(
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: dark ? CustomColor.bgBottomSheet : Colors.white,
                  border: Border.all(
                      color: value.getColorStrength,
                      width: 2,
                      style: BorderStyle.solid),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      offset: const Offset(0, 1),
                      spreadRadius: -1,
                      blurRadius: 2,
                    )
                  ]),
              child: Row(
                children: [
                  Expanded(
                      child: CustomText(
                    value.getPassword,
                    textSize: 16,
                    bold: true,
                  )),
                  InkWell(
                    onTap: () {
                      if (value.getPasswordCopy.isNotEmpty) {
                        if (value.getPasswordCopy != value.getPassword) {
                          Clipboard.setData(
                              ClipboardData(text: value.getPassword));
                          CustomSnackBar().show(context, 'password copy done');
                          PassHistory pass = PassHistory(
                              value.getPassword, DateTime.now().toString());
                          Hive.box<PassHistory>('passwordHistory').add(pass);
                          value.passwordCopy = value.getPassword;
                        }
                      } else {
                        Clipboard.setData(
                            ClipboardData(text: value.getPassword));
                        CustomSnackBar().show(context, 'password copy done');
                        PassHistory pass = PassHistory(
                            value.getPassword, DateTime.now().toString());
                        Hive.box<PassHistory>('passwordHistory').add(pass);
                        value.passwordCopy = value.getPassword;
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: value.getColorStrength,
                      ),
                      child: CustomTextColor('copy', CustomColor.white,
                          textSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 25,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText('password length : ${value.getPassLength}',
                    textSize: 16),
              ),
            ),
            CustomSeekBar(
              onProgressChange: (percent) {
                double ps = 18 / 100;
                int res = (percent * ps).round();
                value.setPassLength(30 - (24 - res));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const CustomText('Including numbers'),
                  const Spacer(),
                  CustomSwitch(
                    isCheck: value.isNumber,
                    onSwitchChanged: (b) {
                      value.setNumber(b);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const CustomText('Including letters'),
                  const Spacer(),
                  CustomSwitch(
                    isCheck: value.letters,
                    onSwitchChanged: (b) {
                      value.setLetters(b);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const CustomText('Capital letters'),
                  const Spacer(),
                  CustomSwitch(
                    isCheck: value.isCapitalLetters,
                    onSwitchChanged: (b) {
                      value.setCapitalLetters(b);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const CustomText('Including !@#%^\$&'),
                  const Spacer(),
                  CustomSwitch(
                    isCheck: value.isCharacter,
                    onSwitchChanged: (b) {
                      value.setCharacter(b);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                value.passwordGenerate();
              },
              child: Container(
                  height: 55,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColor.blue,
                  ),
                  child:
                      CustomTextColor('generate password', CustomColor.white)),
            ),
            Expanded(
                child: ValueListenableBuilder<Box>(
              valueListenable:
                  Hive.box<PassHistory>('passwordHistory').listenable(),
              builder: (context, Box box, child) {
                return Column(
                  children: [
                    box.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Divider(
                              height: 1,
                              color: CustomColor.gryLight,
                            ))
                        : Container(),
                    box.isNotEmpty
                        ? Container(
                            height: 50,
                            margin: const EdgeInsets.only(left: 24, right: 24),
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: CustomText('History of copied passwords',
                                  textSize: 20, bold: true),
                            ),
                          )
                        : Container(),
                    Expanded(
                        child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        index = (box.length - 1) - index;
                        PassHistory pass = box.getAt(index);
                        Jalali j =
                            Jalali.fromDateTime(DateTime.parse(pass.date));
                        return InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: value.getPassword));
                            CustomSnackBar().show(context, 'password copied');
                          },
                          onLongPress: () {
                            CustomDialog().showCheckDialog(
                                context, 'Do you want delete password?', () {
                              box.deleteAt(index);
                              Rute.navigateBack(context);
                            });
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                CustomText(
                                  toStringFormatter(j),
                                  textSize: 14,
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: CustomText(
                                          pass.password,
                                          textSize: 16,
                                          bold: true,
                                        )))
                              ],
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                );
              },
            ))
          ],
        );
      },
    );
  }

  String toStringFormatter(Jalali d) {
    final f = d.formatter;
    return '${f.date.hour}:${f.date.minute} - ${f.y}/${f.m}/${f.d} ';
  }
}
