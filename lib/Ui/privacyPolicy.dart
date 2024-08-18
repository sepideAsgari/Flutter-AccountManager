

import 'package:flutter/material.dart';

import '../CustomWidgets/customWidgets.dart';
import '../Utils/customRute.dart';
import '../Utils/themeManager.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children:  [
              Container(
                height: 60,
                margin: const EdgeInsets.only(bottom: 24),
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 40,
                      height: 40,
                    ),
                    const Expanded(child: CustomText('privacy and policy',
                      textAlign: TextAlign.center,
                    textSize: 22,)),
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
                ),
              ),
              const CustomText('تمامی اطلاعات وارد شده توسط شما چه در حساب چه در کارت کاملا آفلاین بوده و در تلفن همراه شما خواهد بود و در دست فردی حتی توسعه دهنده قرار نمیگیرد.\n\nگرفتن نسخه پشتیبان هم فایلی در تلفن همراه شما ایجاد میکند و خود شما حافظ اطلاعات خود و فایل پشتیبان میباشید و تیم توسعه دهنده هیچگونه مسئولیتی در این زمینه ندارد.\n\nگرفتن دسترسی دوربین فقط برای اسکن کردن QR کد حساب یا کارت میباشد و هیچگونه اجباری در دادن دسترسی نمیباشد.',
              textDirection: TextDirection.rtl,
              textSize: 16,
              textAlign: TextAlign.right),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: CustomText('Aishid',
                    textDirection: TextDirection.rtl,
                    textSize: 16,
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
      ),
    );
  }
}
