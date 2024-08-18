import 'dart:async';
import 'package:acountmanager/Ui/passwordGeneratorPage.dart';
import 'package:acountmanager/Ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/activeProVersionDialog.dart';
import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../Model/account.dart';
import '../Model/bankCard.dart';
import '../Providers/PassPageProvider.dart';
import '../Providers/bankCradPageProvider.dart';
import '../Providers/settingProvider.dart';
import '../Utils/customRute.dart';
import '../Utils/myLog.dart';
import '../Utils/staticData.dart';
import '../Utils/themeManager.dart';
import 'accountUi.dart';
import 'bankCardUi.dart';
import 'makeAccount.dart';
import 'makeBankCard.dart';

class HomeUiNotifier extends ChangeNotifier {
  int selected = 3;

  int get isSelected => selected;

  PageController pageController = PageController(initialPage: 3);

  PageController get getPageController => pageController;

  setSelected(int i) {
    if (selected != i) {
      selected = i;
      try {
        if (pageController.keepPage) {
          pageController.jumpToPage(selected);
        }
      } catch (e) {
        MyLog.e(e.toString());
      }
      notify();
    }
  }

  setSelectedPage(int i) {
    selected = i;
    notify();
  }

  notify() {
    Future.delayed(
      Duration.zero,
      () {
        notifyListeners();
      },
    );
  }
}

class HomeUI extends StatelessWidget {
  HomeUI({Key? key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode(canRequestFocus: false);

  Box account = Hive.box<Account>('accountList');
  Box bank = Hive.box<BankCard>('bankCardList');

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      const Settings(),
      const PasswordGenerator(),
      const BankCardListUI(),
      const PasswordListUI()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: Consumer<HomeUiNotifier>(
        builder: (context, value, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: PageView(
                    children: views,
                    scrollDirection: Axis.horizontal,
                    controller: value.getPageController,
                    onPageChanged: (val) {
                      value.setSelectedPage(val);
                    },
                  ),
                ),
              )),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavigation(
                    selected: value.isSelected,
                    onClickSelected: (i) {
                      value.setSelected(i);
                    },
                    onClickAdd: () {
                      if (context.read<SettingNotifier>().isAccountProVersion) {
                        if (value.isSelected == 2) {
                          Rute.navigate(
                              context,
                              const CreateBankCard(
                                create: true,
                              ));
                        } else if (value.isSelected == 3) {
                          Rute.navigate(
                              context,
                              const CreateAccount(
                                create: true,
                              ));
                        }
                      } else {
                        if (value.isSelected == 2) {
                          // if (bank.length < 2) {
                          Rute.navigate(
                              context,
                              const CreateBankCard(
                                create: true,
                              ));
                          // } else {
                          //   ActiveProVersionDialog().show(context);
                          // }
                        } else if (value.isSelected == 3) {
                          // if (account.length < 5) {
                          Rute.navigate(
                              context,
                              const CreateAccount(
                                create: true,
                              ));
                          // } else {
                          //   ActiveProVersionDialog().show(context);
                          // }
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          );
        },
      )),
    );
  }
}

class BankCardListUI extends StatelessWidget {
  const BankCardListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BankCardPageProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            if (value.getFNSearch.hasFocus) {
              value.getFNSearch.unfocus();
            }
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const CustomText('Your card', textSize: 22),
              ),
              CustomInput(
                textEditingController: value.getTECSearch,
                focusNode: value.getFNSearch,
                isPassword: false,
                hint: 'search',
                icon: 'assets/icons/search.svg',
                number: false,
              ),
              CustomTab(
                selected: value.isSelected,
                onClickSelected: (int i) {
                  value.setSelected(i);
                },
              ),
              Expanded(
                  child: ValueListenableBuilder<Box>(
                valueListenable:
                    Hive.box<BankCard>('bankCardList').listenable(),
                builder: (context, box, child) {
                  return box.isNotEmpty
                      ? ListView.builder(
                          itemCount: box.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            index = (box.length - 1) - index;
                            BankCard bankcard = box.getAt(index);
                            bool search = false;

                            if (value.getTECSearch.text.isNotEmpty) {
                              search = true;
                            }

                            return search
                                ? bankcard.name.trim().toLowerCase().startsWith(
                                        value.getTECSearch.text
                                            .toLowerCase()
                                            .trim())
                                    ? value.isSelected == 0
                                        ? bankcard.favorite
                                            ? itemAccount(
                                                context, box, index, bankcard)
                                            : Container()
                                        : itemAccount(
                                            context, box, index, bankcard)
                                    : Container()
                                : value.isSelected == 0
                                    ? bankcard.favorite
                                        ? itemAccount(
                                            context, box, index, bankcard)
                                        : Container()
                                    : itemAccount(
                                        context, box, index, bankcard);
                          },
                        )
                      : Center(
                          child: Column(
                            children: [
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: const CustomText(
                                    'You havent added a card yet, use the button below to add a new card'),
                              ),
                              Expanded(
                                  child: Container(
                                width: 10,
                                margin: const EdgeInsets.only(bottom: 35),
                                height: double.infinity,
                                color: CustomColor.blue,
                              ))
                            ],
                          ),
                        );
                },
              ))
            ],
          ),
        );
      },
    );
  }

  Widget itemAccount(
      BuildContext context, Box box, int index, BankCard bankCard) {
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Rute.navigate(
            context,
            BankCardUi(
              index: index,
              box: box,
            ));
      },
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: bankCard.number.toString()));
        CustomSnackBar().show(context, 'Card number copy done');
      },
      child: Container(
          width: double.infinity,
          height: w * 0.55,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: StaticData.accountColors.elementAt(bankCard.color),
              boxShadow: [
                BoxShadow(
                    color: CustomColor.white.withOpacity(.2),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
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
                          box.putAt(index, bankCard);
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
                    child: CustomTextColor(bankCard.name, CustomColor.white,
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
                  split4Number(bankCard.number, bankCard.numberVisibility),
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
                    child: CustomTextColor(bankCard.date, CustomColor.white,
                        textSize: 16),
                  ))
                ],
              )),
            ],
          )),
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

class PasswordListUI extends StatelessWidget {
  const PasswordListUI({Key? key}) : super(key: key);

  Widget itemAccount(
      BuildContext context, Box box, int index, Account account) {
    return InkWell(
      onTap: () {
        Rute.navigate(
            context,
            AccountUi(
              box: box,
              index: index,
            ));
      },
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: account.password));
        CustomSnackBar().show(context, 'password copy done');
      },
      child: Container(
        width: double.infinity,
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                account.favorite = !account.favorite;
                box.putAt(index, account);
              },
              child: account.favorite
                  ? SvgPicture.asset(
                      'assets/icons/star1.svg',
                      height: 30,
                      width: 30,
                      color: Colors.yellow,
                    )
                  : SvgPicture.asset(
                      'assets/icons/star0.svg',
                      height: 30,
                      width: 30,
                      color: CustomColor.gry,
                    ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            account.name,
                            textSize: 16,
                            bold: true,
                          ))),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextColor(
                            account.username,
                            CustomColor.gry,
                            textSize: 14,
                          )))
                ],
              ),
            )),
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: CustomColor.gryLight.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset(
                account.icon,
                width: 35,
                height: 35,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PassPageNotifier>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            if (value.getFNSearch.hasFocus) {
              value.getFNSearch.unfocus();
            }
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const CustomText('Your accounts', textSize: 22),
              ),
              CustomInput(
                textEditingController: value.getTECSearch,
                focusNode: value.getFNSearch,
                isPassword: false,
                hint: 'search',
                icon: 'assets/icons/search.svg',
                number: false,
              ),
              CustomTab(
                selected: value.isSelected,
                onClickSelected: (int i) {
                  value.setSelected(i);
                },
              ),
              Expanded(
                  child: ValueListenableBuilder<Box>(
                valueListenable: Hive.box<Account>('accountList').listenable(),
                builder: (context, box, child) {
                  return box.isNotEmpty
                      ? ListView.builder(
                          itemCount: box.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            index = (box.length - 1) - index;
                            Account account = box.getAt(index);
                            bool search = false;

                            if (value.getTECSearch.text.isNotEmpty) {
                              search = true;
                            }

                            return search
                                ? account.name.trim().toLowerCase().startsWith(
                                        value.getTECSearch.text
                                            .toLowerCase()
                                            .trim())
                                    ? value.isSelected == 0
                                        ? account.favorite
                                            ? itemAccount(
                                                context, box, index, account)
                                            : Container()
                                        : itemAccount(
                                            context, box, index, account)
                                    : Container()
                                : value.isSelected == 0
                                    ? account.favorite
                                        ? itemAccount(
                                            context, box, index, account)
                                        : Container()
                                    : itemAccount(context, box, index, account);
                          },
                        )
                      : Center(
                          child: Column(
                            children: [
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: const CustomText(
                                    'you havent added a account yet, use the button below to add a new account'),
                              ),
                              Expanded(
                                  child: Container(
                                width: 10,
                                margin: EdgeInsets.only(bottom: 35),
                                height: double.infinity,
                                color: CustomColor.blue,
                              ))
                            ],
                          ),
                        );
                },
              ))
            ],
          ),
        );
      },
    );
  }
}
