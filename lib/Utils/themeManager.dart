import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChangeThemeNotifier extends ChangeNotifier {
  bool b = true;
  bool get isB => b;
  bool c = true;
  bool get isC => c;

  setB(bool b) {
    this.b = b;
    notifyListeners();
  }

  setC(bool b) {
    c = b;
    notifyListeners();
  }

  ThemeMode themeMode =
      CatchTheme.getTheme() ? ThemeMode.dark : ThemeMode.light;

  ThemeMode get getThemeMode => themeMode;

  bool dark = CatchTheme.getTheme();

  bool get isDark => dark;

  switchTheme(bool isOn) {
    dark = isOn;
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    CatchTheme.setTheme(isOn);
    notifyListeners();
  }
}

class CatchTheme {
  static init() async {
    await Hive.openBox('theme');
  }

  static setTheme(bool isOn) {
    Box box = Hive.box('theme');
    box.put('dark', isOn);
  }

  static bool getTheme() {
    return Hive.box('theme').get('dark', defaultValue: false);
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
      fontFamily: 'irans',
      scaffoldBackgroundColor: CustomColor.bgColor,
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColor.bgBottomSheet,
      ),
      brightness: Brightness.dark,
      primaryColor: const Color(0xff665D8C),
      buttonTheme: const ButtonThemeData(
          colorScheme: ColorScheme.dark(),
          buttonColor: const Color(0xff665D8C)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff665D8C),
      ),
      primaryIconTheme: IconThemeData(
        color: CustomColor.white,
      ),
      colorScheme: const ColorScheme.dark(),
      iconTheme: IconThemeData(color: CustomColor.white));

  static final lightTheme = ThemeData(
      fontFamily: 'irans',
      scaffoldBackgroundColor: CustomColor.white,
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xff40356F),
      ),
      brightness: Brightness.light,
      primaryColor: Colors.red,
      buttonTheme: const ButtonThemeData(
          colorScheme: ColorScheme.light(), buttonColor: Colors.red),
      primaryIconTheme: IconThemeData(
        color: CustomColor.gry,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff40356F),
      ),
      colorScheme: const ColorScheme.light(),
      iconTheme: IconThemeData(color: CustomColor.gry));
}

class CustomColor {
  static Color bgColor = const Color(0xFF0D1018);
  static Color blue = Color(0xff665D8C);
  static Color lightBlue = Colors.blue.withOpacity(0.7);
  static Color white = Colors.white;
  static Color textColor = const Color(0xFF333333);
  static Color gry = const Color(0xFF828282);
  static Color gryLight = const Color(0xFFc4c4c4);
  static Color borderInput = const Color(0xFF202635);
  static Color bgInput = const Color(0xFF161920);
  static Color bnbColor = const Color(0x990D1018);
  static Color bgBottomSheet = const Color(0xFF1A1C24);
  static Color bgSettingRed = const Color(0xFF241A22);
  static Color gradientBegin = const Color(0xFF5D7BF2);
  static Color gradientEnd = const Color(0xFF39E4C6);
}
