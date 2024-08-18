import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/themeManager.dart';

typedef OnClick = Function();
typedef OnClickSelected = Function(int i);
typedef OnCheck = Function(bool check);
typedef OnProgressChange = Function(int percent);

class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {Key? key,
      this.textSize = 18,
      this.bold = false,
      this.textAlign = TextAlign.center,
      this.textDirection = TextDirection.ltr})
      : super(key: key);

  final String text;
  final double textSize;
  final bool bold;
  final TextAlign textAlign;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Text(
      text,
      textDirection: textDirection,
      textAlign: textAlign,
      style: TextStyle(
          color: dark ? CustomColor.white : CustomColor.textColor,
          fontSize: textSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}

class CustomTextColor extends StatelessWidget {
  const CustomTextColor(this.text, this.color,
      {Key? key,
      this.textSize = 18,
      this.textAlign = TextAlign.center,
      this.textDirection = TextDirection.ltr})
      : super(key: key);

  final String text;
  final double textSize;
  final Color color;
  final TextAlign textAlign;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: textDirection,
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: textSize),
    );
  }
}

typedef OnSwitchChanged = void Function(bool b);

class CustomSwitch extends StatelessWidget {
  const CustomSwitch(
      {Key? key, required this.isCheck, required this.onSwitchChanged})
      : super(key: key);
  final bool isCheck;
  final OnSwitchChanged onSwitchChanged;
  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return InkWell(
      highlightColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        onSwitchChanged.call(!isCheck);
      },
      child: Container(
        width: 50,
        height: 28,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isCheck
                ? CustomColor.blue
                : dark
                    ? CustomColor.bgBottomSheet
                    : Colors.transparent,
            border: Border.all(
                color: isCheck
                    ? Colors.blue
                    : dark
                        ? Colors.white10
                        : CustomColor.gry.withOpacity(0.3),
                width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: AnimatedAlign(
          alignment: isCheck ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
                color: isCheck ? Colors.white : CustomColor.gry,
                borderRadius: BorderRadius.circular(9.5)),
          ),
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
      required this.textEditingController,
      required this.focusNode,
      this.isPassword = false,
      this.hint = '',
      this.icon = '',
      this.horizontalMargin = 32,
      this.verticalMargin = 16,
      required this.number,
      this.length = 10000})
      : super(key: key);

  final bool isPassword;
  final bool number;
  final String hint;
  final String icon;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final double horizontalMargin;
  final double verticalMargin;
  final int length;

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Container(
      width: double.infinity,
      height: 55,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: dark ? CustomColor.bgBottomSheet : Colors.white,
          border: Border.all(
              color: focusNode.hasFocus
                  ? Colors.blue
                  : dark
                      ? Colors.white12
                      : CustomColor.gry.withOpacity(.3),
              width: 2,
              style: BorderStyle.solid),
          boxShadow: [
            focusNode.hasFocus
                ? const BoxShadow(
                    color: Colors.blue,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 5,
                    blurStyle: BlurStyle.outer)
                : BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    offset: const Offset(0, 1),
                    spreadRadius: -1,
                    blurRadius: 2,
                  )
          ]),
      child: Row(
        children: [
          icon.isNotEmpty
              ? Container(
                  width: 55,
                  height: 55,
                  padding: const EdgeInsets.all(15.5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(icon, color: CustomColor.blue),
                )
              : Container(),
          Expanded(
            child: TextFormField(
              maxLength: length,
              autocorrect: true,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: dark ? CustomColor.white : CustomColor.textColor,
                  fontSize: 16,
                  letterSpacing: 0),
              cursorColor: Colors.blue,
              cursorHeight: 26.5,
              autofocus: false,
              controller: textEditingController,
              focusNode: focusNode,
              textAlignVertical: TextAlignVertical.center,
              enableSuggestions: isPassword,
              keyboardType: number ? TextInputType.number : TextInputType.text,
              cursorRadius: const Radius.circular(10),
              obscureText: isPassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    left: icon.isNotEmpty ? 0 : 10,
                    right: 10,
                    top: 8,
                    bottom: 8),
                filled: false,
                enabledBorder:
                    const UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: hint,
                hintStyle: TextStyle(color: CustomColor.gry, fontSize: 16),
                counter: const Offstage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSeekBar extends StatefulWidget {
  const CustomSeekBar({Key? key, required this.onProgressChange})
      : super(key: key);
  final OnProgressChange onProgressChange;
  @override
  State<CustomSeekBar> createState() => _CustomSeekBarState();
}

class _CustomSeekBarState extends State<CustomSeekBar> {
  bool isTouch = false;
  double thumbSize = 24 - 12.5;
  int percent = 50;
  bool setSize = false;

  onDragStart(double max, DragStartDetails details) {
    setState(() {
      isTouch = true;
    });
    double w = details.globalPosition.dx;
    if (w > 32 && w < max + 6) {
      percent = (100 / ((max) / (w - 32))).round();
      widget.onProgressChange.call(percent);
      setState(() {
        thumbSize = w - 32;
      });
    }
  }

  onDragUpdate(double max, DragUpdateDetails details) {
    double w = details.globalPosition.dx;
    if (w > 32 && w < max + 6) {
      percent = (100 / ((max - 26) / (w - 32))).round();
      widget.onProgressChange.call(percent);
      setState(() {
        thumbSize = w - 32;
      });
    }
  }

  onDragEnd(DragEndDetails details) {
    setState(() {
      isTouch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 52;
    if (!setSize) {
      thumbSize = w / 2;
      setSize = true;
    }

    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: [
          Positioned(
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: w,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 12.5),
                    decoration: BoxDecoration(
                        color: CustomColor.gry.withOpacity(.3),
                        borderRadius: BorderRadius.circular(3)),
                  ))),
          Positioned(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: thumbSize,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 12.5),
                    decoration: BoxDecoration(
                        color: CustomColor.blue,
                        borderRadius: BorderRadius.circular(3)),
                  ))),
          GestureDetector(
            onHorizontalDragStart: (details) => onDragStart(w, details),
            onHorizontalDragUpdate: (details) => onDragUpdate(w, details),
            onHorizontalDragEnd: (details) => onDragEnd(details),
            child: Stack(
              children: [
                Positioned(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: isTouch ? 30 : 25,
                      height: isTouch ? 30 : 25,
                      margin: EdgeInsets.only(left: thumbSize),
                      decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius:
                              BorderRadius.circular(isTouch ? 15 : 12.5),
                          border:
                              Border.all(color: CustomColor.blue, width: 3))),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab(
      {Key? key, required this.selected, required this.onClickSelected})
      : super(key: key);

  final int selected;
  final OnClickSelected onClickSelected;

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              onClickSelected.call(1);
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              child: CustomTextColor(
                  'All',
                  selected == 1
                      ? CustomColor.blue
                      : dark
                          ? CustomColor.white.withOpacity(.5)
                          : CustomColor.bgColor.withOpacity(.5),
                  textSize: selected == 1 ? 18 : 16),
            ),
          ),
          InkWell(
            onTap: () {
              onClickSelected.call(0);
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              child: CustomTextColor(
                  'Favorites',
                  selected == 0
                      ? CustomColor.blue
                      : dark
                          ? CustomColor.white.withOpacity(.5)
                          : CustomColor.bgColor.withOpacity(.5),
                  textSize: selected == 0 ? 18 : 16),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation(
      {Key? key,
      required this.selected,
      required this.onClickSelected,
      required this.onClickAdd})
      : super(key: key);

  final OnClick onClickAdd;
  final OnClickSelected onClickSelected;
  final int selected;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool dark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Container(
      height: 88,
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.transparent,
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          Positioned(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: dark ? CustomColor.bgBottomSheet : CustomColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.gry.withOpacity(.3),
                      offset: const Offset(0, -1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ]),
              height: 60,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onClickSelected.call(0);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset('assets/icons/settings.svg',
                            color: selected == 0
                                ? CustomColor.blue
                                : CustomColor.gry),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onClickSelected.call(1);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset('assets/icons/rotate_right.svg',
                            color: selected == 1
                                ? CustomColor.blue
                                : CustomColor.gry),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: selected == 3 || selected == 2 ? w / 5 : 0),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onClickSelected.call(2);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset('assets/icons/credit_card.svg',
                            color: selected == 2
                                ? CustomColor.blue
                                : CustomColor.gry),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onClickSelected.call(3);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset('assets/icons/safe_box.svg',
                            color: selected == 3
                                ? CustomColor.blue
                                : CustomColor.gry),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          Positioned(
              child: Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin:
                  EdgeInsets.only(top: selected == 3 || selected == 2 ? 0 : 88),
              child: FloatingActionButton(
                onPressed: () {
                  onClickAdd.call();
                },
                child: SvgPicture.asset(
                  'assets/icons/add.svg',
                  color: CustomColor.white,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
