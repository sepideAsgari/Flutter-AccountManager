import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../Ui/passwordScreen.dart';
import '../Utils/customRute.dart';
import '../Utils/themeManager.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offset = 0;
  double _page = 0;
  int _pageCount = 3;

  PageController pageController = PageController();
  PageController get getPageController => pageController;

  PageOffsetNotifier() {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page!;
      notify();
    });
  }

  setPageCount(int count) {
    _pageCount = count;
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

  double get offset => _offset;

  int get pageCount => _pageCount;

  double get page => _page;
}

class IntroSlider extends StatelessWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return ChangeNotifierProvider(
        create: (context) => PageOffsetNotifier(),
        child: Scaffold(
          body: SafeArea(
            child: Consumer<PageOffsetNotifier>(
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Positioned(
                        child: Container(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                  color: CustomColor.blue,
                                  width: double.infinity,
                                  child: Column(
                                    children: const [
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      SizedBox(
                                          height: 40, child: PageSwipeCounter())
                                    ],
                                  ))),
                          Expanded(
                              flex: 6,
                              child: Container(
                                color: CustomColor.blue,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: w,
                                      height: 61,
                                      child: CustomPaint(
                                        painter: CurvedPaint(dark),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: dark
                                            ? CustomColor.bgColor
                                            : Colors.white,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )),
                    Positioned(
                        child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: value.getPageController,
                      children: const <Widget>[
                        PageSwiperItem(
                          name: 'Security',
                          img: 'assets/images/3dLock.png',
                          description: 'High security abd offline',
                        ),
                        PageSwiperItem(
                          name: 'Bank card',
                          img: 'assets/images/3dCard.png',
                          description:
                              'Add a bank card to have instant information',
                        ),
                        PageSwiperItem(
                          name: 'Backup',
                          img: 'assets/images/3dSafe.png',
                          description: 'offline backup capability',
                        ),
                      ],
                    )),
                    Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: w,
                          height: 100,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 50),
                          child: Stack(
                            children: [
                              Positioned(
                                  child: Align(
                                alignment: Alignment.center,
                                child: CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 4.0,
                                  curve: Curves.easeIn,
                                  percent: (1 / value._pageCount.toDouble()) *
                                      (value.page + 1),
                                  backgroundColor: Colors.white,
                                  progressColor: Colors.blue,
                                ),
                              )),
                              Positioned(
                                  child: Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    if (value.page.round() ==
                                        (value.pageCount - 1)) {
                                      Rute.navigateClose(
                                          context,
                                          const PasswordScreen(
                                              passwordScreenMode:
                                                  PasswordScreenMode
                                                      .createPassword));
                                    }
                                    if (value.page.round() + 1 <=
                                        value._pageCount) {
                                      value.getPageController.animateToPage(
                                          value.page.round() + 1,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Icon(
                                      value.page.round() == value.pageCount - 1
                                          ? Icons.done
                                          : Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    value.page.round() != value.pageCount - 1
                        ? Positioned(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: 70,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 32),
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      value.getPageController.animateToPage(
                                          value.pageCount - 1,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeIn);
                                    },
                                    child: const Text('Skip',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              },
            ),
          ),
        ));
  }
}

class PageSwiperItem extends StatelessWidget {
  final String name;
  final String description;
  final String img;

  const PageSwiperItem(
      {Key? key,
      required this.name,
      required this.description,
      required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.only(top: 70, bottom: 50),
            padding: const EdgeInsets.all(32),
            child: Image(
              image: AssetImage(img),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
                bottom: 150, top: 70, right: 50, left: 50),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 35,
                      color: dark ? CustomColor.white : CustomColor.textColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 20,
                      color: CustomColor.gry,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CurvedPaint extends CustomPainter {
  bool dark = false;

  CurvedPaint(this.dark);

  @override
  void paint(Canvas canvas, Size size) async {
    double w = size.width;
    double h = 60;

    var paint = Paint();
    var path = Path();

    paint.color = dark ? CustomColor.bgColor : CustomColor.white;
    paint.style = PaintingStyle.fill;

    path.moveTo(0, h);
    path.cubicTo((w / 2) / 2, 0, ((w / 2) / 2) * 3, 0, w, h);
    path.lineTo(w, h + 2);
    path.lineTo(0, h + 2);
    path.lineTo(0, h);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class PageSwipeCounter extends StatelessWidget {
  const PageSwipeCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, value, child) {
        int count = value._pageCount;
        return Container(
          alignment: Alignment.center,
          width: ((7 * (count - 1)) + (count * 6)) + 30,
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: count,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 7,
                        width: index == value.page.round() ? 30 : 7,
                        margin: const EdgeInsets.only(left: 3, right: 3),
                        decoration: BoxDecoration(
                            color: index == value.page.round()
                                ? Colors.white
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
