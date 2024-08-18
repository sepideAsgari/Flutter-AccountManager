// import 'package:accountManager/Utils/bazar.dart';
// import 'package:accountManager/Utils/customRute.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../Utils/themeManager.dart';
// import 'customSnackbar.dart';
// import 'customWidgets.dart';
//
// class ActiveProVersionDialog {
//
//   show(BuildContext context){
//     bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         enableDrag: true,
//         isScrollControlled: true,
//         isDismissible: true,
//         builder: (context) {
//           return Container(
//               decoration: const BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.0),
//                       topRight: Radius.circular(30.0))),
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: [
//                    SvgPicture.asset(
//                      'assets/icons/bottom_s.svg',
//                      color: CustomColor.gry,
//                    ),
//                    Container(
//                        margin: const EdgeInsets.only(top: 20),
//                        padding: const EdgeInsets.only(top: 20),
//                        decoration: BoxDecoration(
//                            color: dark ? CustomColor.bgBottomSheet : CustomColor.white,
//                            borderRadius: const BorderRadius.only(
//                                topLeft: Radius.circular(30.0),
//                                topRight: Radius.circular(30.0))),
//                      child: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        children:  [
//                          const Align(alignment: Alignment.topRight,
//                            child: Padding(
//                                padding: EdgeInsets.only(right: 16 , top: 8 , bottom: 8),
//                                child: CustomText('ارتقا به نسخه طلایی' , textSize: 18,bold: true,)),),
//                          Container(
//                            alignment: Alignment.topRight,
//                            padding: const EdgeInsets.only(right: 16 , top: 16 , bottom: 16),
//                            child: const CustomText('- حذف تبلیغات\n- ساختن حساب و کارت نامحدود\n- حالت شب\n- گرفتن پشتیبانی از اطلاعات' , textSize: 16,textAlign: TextAlign.right,textDirection: TextDirection.rtl),
//                          ),
//                           Align(alignment: Alignment.topRight,
//                            child: Padding(
//                                padding: const EdgeInsets.only(right: 16 , top: 8 , bottom: 8),
//                                child: CustomTextColor('با خرید از طریق حساب بازار خود با حذف و نصب مجدد برنامه همچنان نسخه طلایی برای شما فعال میباشد' , CustomColor.gry , textSize: 16,textAlign: TextAlign.right,)),),
//                          InkWell(
//                            onTap: () {
//                              BazarPayment.isLogin().then((value){
//                                if(value!){
//                                  BazarPayment.purchase(context).then((value){
//                                    if(value){
//                                      CustomSnackBar().show(context, 'خرید با موفقیت انجام شد');
//                                      Rute.navigateBack(context);
//                                    }else{
//                                      CustomSnackBar().show(context, 'خرید با مشکل مواجه شد');
//                                      Rute.navigateBack(context);
//                                    }
//                                  });
//                                }else{
//                                  CustomSnackBar().show(context, 'وارد حساب خود در بازار شوید');
//                                  Rute.navigateBack(context);
//                                }
//                              });
//                            },
//                            child: Container(
//                                height: 55,
//                                alignment: Alignment.center,
//                                margin: const EdgeInsets.all(16),
//                                decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(10),
//                                  color: CustomColor.blue,
//                                ),
//                                child:
//                                CustomTextColor('خرید 10,000 تومان', CustomColor.white)),
//                          ),
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//           );
//         },);
//   }
//
// }
