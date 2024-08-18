import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../CustomWidgets/customDialog.dart';
import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../CustomWidgets/shareAccountDialog.dart';
import '../Model/account.dart';
import '../Utils/customRute.dart';
import '../Utils/staticData.dart';
import '../Utils/themeManager.dart';
import 'makeAccount.dart';

class AccountUi extends StatelessWidget {
  const AccountUi({Key? key, required this.box, required this.index})
      : super(key: key);

  final Box box;
  final int index;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ValueListenableBuilder<Box>(
            valueListenable: box.listenable(),
            builder: (context, val, child) {
              Account account = val.getAt(index);
              return Column(
                children: [
                  SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              ShareAccountDialog()
                                  .showAccount(context, account);
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
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      account.icon,
                      width: w / 3.5,
                      height: w / 3.5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    alignment: Alignment.center,
                    child: CustomText(account.name, textSize: 22, bold: true),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: CustomTextColor(
                        account.website, CustomColor.gry.withOpacity(.7),
                        textSize: 16),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
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
                                  ClipboardData(text: account.username));
                              CustomSnackBar()
                                  .show(context, 'username copy done');
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
                                  'username', CustomColor.gry.withOpacity(.9),
                                  textSize: 14),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: CustomText(account.username, textSize: 18),
                            ))
                          ],
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
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
                                  ClipboardData(text: account.password));
                              CustomSnackBar()
                                  .show(context, 'password copy done');
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
                                  'password', CustomColor.gry.withOpacity(.9),
                                  textSize: 14),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: CustomText(account.password, textSize: 18),
                            ))
                          ],
                        ))
                      ],
                    ),
                  ),
                  account.description.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.only(top: 24),
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 16),
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
                                child: CustomTextColor('description',
                                    CustomColor.gry.withOpacity(.9),
                                    textSize: 14),
                              ),
                              Expanded(
                                  child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                alignment: Alignment.topRight,
                                child: CustomText(account.description,
                                    textSize: 18),
                              ))
                            ],
                          ))
                      : Container(),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Rute.navigate(
                          context,
                          CreateAccount(
                            create: false,
                            account: account,
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
                            CustomDialog().showCheckDialog(
                                context, 'Do you want to delete this account?',
                                () {
                              CustomSnackBar().show(
                                  context, 'Account ${account.name} deleted');
                              StaticData.deleteAccount(box, index);
                              Rute.navigateBack(context);
                              Rute.navigateBack(context);
                            });
                          },
                          child: const CustomTextColor(
                              'delete account', Colors.red))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
