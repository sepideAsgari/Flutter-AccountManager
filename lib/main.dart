import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'CustomWidgets/customWidgets.dart';
import 'CustomWidgets/introSlider.dart';
import 'Model/account.dart';
import 'Model/bankCard.dart';
import 'Model/passHistory.dart';
import 'Providers/PassPageProvider.dart';
import 'Providers/bankCradPageProvider.dart';
import 'Providers/createAccountProvider.dart';
import 'Providers/createBankCard.dart';
import 'Providers/passwordGeneratorProvider.dart';
import 'Providers/passwordProvider.dart';
import 'Providers/settingProvider.dart';
import 'Ui/homeUi.dart';
import 'Ui/passwordScreen.dart';
import 'Utils/customRute.dart';
import 'Utils/themeManager.dart';

void main() async {
  await Hive.initFlutter();
  CatchTheme.init();
  SettingNotifier.init();
  PasswordChangeNotifier.initBox();

  Hive.registerAdapter(CardAdapter());
  Hive.registerAdapter(PassHistoryAdapter());
  Hive.registerAdapter(AccountAdapter());

  await Hive.openBox<PassHistory>('passwordHistory');
  await Hive.openBox<Account>('accountList');
  await Hive.openBox<BankCard>('bankCardList');

  // Ad.init();
  //
  // BazarPayment.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChangeThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PasswordChangeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeUiNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PassPageNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PasswordGeneratorNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateAccountNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateBankCardNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankCardPageProvider(),
        )
      ],
      child: Consumer<ChangeThemeNotifier>(
        builder: (context, value, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              themeMode: value.getThemeMode,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              home: Directionality(
                  textDirection: TextDirection.rtl, child: const MyHomePage()));
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    initDisableScreenShot();
    Timer(
      const Duration(seconds: 2),
      () {
        bool login = Hive.box('userPassword').get('login', defaultValue: false);
        if (login) {
          Rute.navigateClose(
              context,
              const PasswordScreen(
                  passwordScreenMode: PasswordScreenMode.loginPassword));
        } else {
          Rute.navigateClose(context, const IntroSlider());
        }
      },
    );
    super.initState();
  }

  initDisableScreenShot() async {
    bool sd = context.read<SettingNotifier>().isDisableScreenShot;
    if (sd) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset('assets/icons/lock.svg',
              width: 100, height: 100, color: CustomColor.blue),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: CustomText(
              'َAccount Manager',
              textSize: 25,
            ),
          )
        ],
      ),
    ));
  }
}
