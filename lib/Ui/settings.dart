import 'package:acountmanager/Ui/passwordScreen.dart';
import 'package:acountmanager/Ui/privacyPolicy.dart';
import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CustomWidgets/activeProVersionDialog.dart';
import '../CustomWidgets/customDialog.dart';
import '../CustomWidgets/customSnackbar.dart';
import '../CustomWidgets/customWidgets.dart';
import '../Providers/settingProvider.dart';
import '../Utils/backUp.dart';
import '../Utils/bazar.dart';
import '../Utils/customRute.dart';
import '../Utils/themeManager.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Consumer2<SettingNotifier, ChangeThemeNotifier>(
          builder: (context, value, value2, child) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: const CustomText('Settings', textSize: 22),
                ),
                // !value.isAccountProVersion ? BannerAd('e5e9661d-c43a-4ec2-be09-f9f5e77298fa',BannerAdSize.BANNER,
                //   onAdLoaded: (ad) {
                //
                //   },
                //   onAdClicked: (ad) {
                //     ad.loadAd();
                //   },
                // ) : Container(),
                // !value.isAccountProVersion ? topic('ارتقا') : Container(),
                // !value.isAccountProVersion ? clickItem(
                //     'ارتقا به نسخه طلایی', 'assets/icons/verified.svg', () {
                //   // ActiveProVersionDialog().show(context);
                // }) : Container(),
                topic('General'),
                switchItem(value2.isDark, 'Dark mode', 'assets/icons/sun.svg',
                    (check) {
                  // if(value.isAccountProVersion){
                  value2.switchTheme(check);
                  // }else{
                  //   ActiveProVersionDialog().show(context);
                  // }
                }),
                switchItem(value.isFingerPrintAuth, 'Fingerprint login',
                    'assets/icons/fingerprint.svg', (check) {
                  value.setFingerPrintAuth(check);
                }),
                clickItem('Change password', 'assets/icons/key.svg', () {
                  Rute.navigate(
                      context,
                      const PasswordScreen(
                          passwordScreenMode:
                              PasswordScreenMode.changePassword));
                }),
                switchItem(value.disableScreenShot, 'Disable screenshot',
                    'assets/icons/camera.svg', (check) async {
                  if (check) {
                    await FlutterWindowManager.addFlags(
                        FlutterWindowManager.FLAG_SECURE);
                  } else {
                    await FlutterWindowManager.clearFlags(
                        FlutterWindowManager.FLAG_SECURE);
                  }
                  value.setDisableScreenShot(check);
                }),
                topic('Backup'),
                clickItem('Create backup', 'assets/icons/export.svg', () async {
                  // if(value.isAccountProVersion){
                  var status = await Permission.storage.status;
                  if (status.isDenied) {
                    if (await Permission.storage.request().isGranted) {
                      CustomDialog().showBackUpDialog(context, false);
                    } else {
                      CustomSnackBar()
                          .show(context, 'Access to the files was not granted');
                    }
                  } else {
                    CustomDialog().showBackUpDialog(context, false);
                  }
                  // }else{
                  //   ActiveProVersionDialog().show(context);
                  // }
                }),
                clickItem('Open backup', 'assets/icons/import.svg', () async {
                  // if(value.isAccountProVersion){
                  var status = await Permission.storage.status;
                  if (status.isDenied) {
                    if (await Permission.storage.request().isGranted) {
                      CustomDialog().showBackUpDialog(context, true);
                    } else {
                      CustomSnackBar()
                          .show(context, 'Access to the files was not granted');
                    }
                  } else {
                    CustomDialog().showBackUpDialog(context, true);
                  }
                  // }else{
                  //   ActiveProVersionDialog().show(context);
                  // }
                }),
                // !value.isAccountProVersion ? BannerAd('e5e9661d-c43a-4ec2-be09-f9f5e77298fa',BannerAdSize.BANNER,
                //   onAdLoaded: (ad) {
                //
                //   },
                //   onAdClicked: (ad) {
                //     ad.loadAd();
                //   },
                // ) : Container(),
                topic('Contact us'),
                clickItem('Telegram', 'assets/icons/telegram.svg', () {
                  _launchURL('');
                }),
                clickItem('Email', 'assets/icons/email.svg', () {
                  final Uri emailLaunchUri =
                      Uri(scheme: 'mailto', path: 'sepide.asgari88@gmail.com');
                  launchUrl(emailLaunchUri);
                }),
                topic('Help'),
                clickItem(
                    'Privacy and policy', 'assets/icons/privacyPolicy.svg', () {
                  Rute.navigate(context, const PrivacyPolicy());
                }),
              ],
            );
          },
        ));
  }

  void _launchURL(String _url) async => await canLaunchUrl(Uri.parse(_url))
      ? await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication)
      : throw 'Could not launch $_url';

  Widget topic(String text) {
    return Container(
      width: double.infinity,
      height: 30,
      margin: const EdgeInsets.only(right: 16, top: 4),
      alignment: Alignment.centerLeft,
      child: CustomTextColor(text, CustomColor.gry, textSize: 18),
    );
  }

  Widget clickItem(String text, String icon, OnClick onClick) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: () {
          onClick.call();
        },
        borderRadius: BorderRadius.circular(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(right: 10),
              decoration: ShapeDecoration(
                  color: CustomColor.gry.withOpacity(.1),
                  shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
              child: SvgPicture.asset(icon, color: CustomColor.blue),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: CustomText(text, textSize: 18),
            )),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  color: CustomColor.blue, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget switchItem(bool s, String text, String icon, OnCheck onCheck) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(right: 10),
            decoration: ShapeDecoration(
                color: CustomColor.gry.withOpacity(.1),
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)))),
            child: SvgPicture.asset(icon, color: CustomColor.blue),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: CustomText(text, textSize: 18),
          )),
          CustomSwitch(
            isCheck: s,
            onSwitchChanged: (b) {
              onCheck.call(b);
            },
          ),
        ],
      ),
    );
  }
}
