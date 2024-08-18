//
//
// import 'package:cafebazaar_flutter/cafebazaar_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../Providers/settingProvider.dart';
//
// class BazarPayment {
//
//   static final CafebazaarFlutter _bazaar = CafebazaarFlutter.instance;
//   static InAppPurchase? inApp;
//
//   static init(){
//      inApp = _bazaar.inAppPurchase('MIHNMA0GCSqGSIb3DQEBAQUAA4G7ADCBtwKBrwDPJE6j4OBkZV9WZVwJ0AExLiYZ6qA0DDWJCJBaPq0d12UCyQZyHZnRGRzfbvEJR8wse+xxqpSY65TM5BL61Djujl2fJPGYz/lJUQ1u96T4aybF0UVoHYVb8VOayFGN61/fyILraksN17HGAPlDgYPXuQgQFgiBr3ykEyyOC+MpxvPcCZyXBaYbqJ4G+zwRr0BqYS17jNHG1y9ZYse0J/jZZGPXkF3H6Rug/4hHWeUCAwEAAQ==');
//   }
//
//   static Future<bool> purchase(BuildContext context) async {
//     final PurchaseInfo? purchaseInfo = await inApp?.purchase("1000", payLoad: "Your payload");
//     if(purchaseInfo != null) {
//       context.read<SettingNotifier>().setAccountProVersion();
//       return true;
//     }else{
//       return false;
//     }
//   }
//
//   static getTest() async {
//     final List<PurchaseInfo>? purchasedProducts = await inApp?.getPurchasedProducts();
//     print('PRODUCT LIST : $purchasedProducts');
//   }
//
//   static dc() async {
//     await inApp?.disconnect();
//   }
//
//   static Future<bool?> isLogin() async {
//     return await _bazaar.isLoggedIn();
//   }
//
// }
