import 'dart:convert';
import 'package:acountmanager/Ui/qrCodeScanner.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../CustomWidgets/iconSelectDialog.dart';
import '../Model/account.dart';
import '../Providers/createAccountProvider.dart';
import '../Utils/ad.dart';
import '../Utils/customRute.dart';
import '../Utils/myLog.dart';
import '../Utils/themeManager.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount(
      {Key? key, required this.create, this.account, this.index})
      : super(key: key);

  final bool create;
  final Account? account;
  final int? index;

  @override
  Widget build(BuildContext context) {
    // Ad.showAdPage();
    if (!create) {
      context.read<CreateAccountNotifier>().init(account!, index!);
    }
    return WillPopScope(
      onWillPop: () async {
        context.read<CreateAccountNotifier>().clear();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Consumer<CreateAccountNotifier>(
                builder: (context, value, child) {
                  return Stack(
                    children: [
                      Positioned(
                        child: SingleChildScrollView(
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
                                        child: CustomText('Add new account',
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
                                              Account account =
                                                  Account.fromJson(json
                                                          .decode(value)
                                                      as Map<String, dynamic>);
                                              Box box = Hive.box<Account>(
                                                  'accountList');
                                              box.add(account);
                                              CustomSnackBar().show(context,
                                                  '${account.name} account added');
                                              Rute.navigateBack(context);
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
                              Row(
                                children: [
                                  DottedBorder(
                                    color: value.getAccount.icon.isNotEmpty
                                        ? Colors.transparent
                                        : CustomColor.blue,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(20),
                                    strokeWidth: 1,
                                    strokeCap: StrokeCap.round,
                                    padding: EdgeInsets.zero,
                                    dashPattern: const [5, 5],
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        IconSelectDialog().show(context,
                                            (icon) {
                                          value.setIcon(icon);
                                        });
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: CustomColor.gryLight
                                              .withOpacity(.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: value.getAccount.icon.isNotEmpty
                                            ? SvgPicture.asset(
                                                value.getAccount.icon,
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              )
                                            : Icon(Icons.add,
                                                size: 30,
                                                color: CustomColor.blue),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: CustomInput(
                                      focusNode: value.getFNName,
                                      textEditingController: value.getTECName,
                                      hint: 'name',
                                      isPassword: false,
                                      horizontalMargin: 0,
                                      number: false,
                                    ),
                                  )),
                                ],
                              ),
                              CustomInput(
                                focusNode: value.getFNUsername,
                                textEditingController: value.getTECUsername,
                                hint: 'username',
                                isPassword: false,
                                horizontalMargin: 0,
                                verticalMargin: 8,
                                icon: 'assets/icons/user.svg',
                                number: false,
                              ),
                              CustomInput(
                                focusNode: value.getFNPassword,
                                textEditingController: value.getTECPassword,
                                hint: 'password',
                                isPassword: false,
                                horizontalMargin: 0,
                                verticalMargin: 8,
                                icon: 'assets/icons/key.svg',
                                number: false,
                              ),
                              CustomInput(
                                focusNode: value.getFNWebSite,
                                textEditingController: value.getTECWebSite,
                                hint: 'web',
                                isPassword: false,
                                horizontalMargin: 0,
                                verticalMargin: 8,
                                icon: 'assets/icons/link.svg',
                                number: false,
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
                              // ColorSelected(
                              //   selected: value.getAccount.color,
                              //   onClickSelected: (i) {
                              //      value.setColorSelected(i);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
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
                              child: CustomTextColor(
                                  create ? 'Add account' : 'Edit',
                                  CustomColor.white)),
                        ),
                      ))
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
