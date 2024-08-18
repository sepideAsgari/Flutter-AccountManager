

import 'package:flutter/foundation.dart';

class MyLog {

  static e(String log){
    if (kDebugMode) {
      print(log);
    }
  }

}