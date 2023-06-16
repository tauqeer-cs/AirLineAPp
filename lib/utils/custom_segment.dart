import 'package:flutter/material.dart';

import '../theme/styles.dart';
import '../theme/typography.dart';


class CustomSegmentControl extends StatefulWidget {
  final Color? primaryColor;
  final VoidCallback optionOneTapped;
  final VoidCallback optionTwoTapped;

  final double? customBorderWidth;
  final double? customVerticalPadding;
  final double? customRadius;

  final TextStyle? customSelectedStyle;
  final TextStyle? customNoSelectedStyle;

  final String textOne;
  final String textTwo;

  final bool isSelectedOption1;

  const CustomSegmentControl(
      {super.key,
        this.primaryColor,
        required this.optionOneTapped,
        required this.optionTwoTapped,
        required this.textOne,
         this.isSelectedOption1 = true,
        required this.textTwo, this.customRadius,  this.customBorderWidth, this.customVerticalPadding, this.customSelectedStyle, this.customNoSelectedStyle});

  @override
  CustomSegmentControlState createState() => CustomSegmentControlState();
}

class CustomSegmentControlState extends State<CustomSegmentControl> {
  bool _isSelectedOption1 = true;


  @override
  void initState() {
    super.initState();
    _isSelectedOption1 = widget.isSelectedOption1;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: widget.primaryColor ?? Styles.kPrimaryColor,
          width: widget.customBorderWidth ?? 2,
        ),
        borderRadius: BorderRadius.circular(widget.customRadius ??  24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectedOption1 = true;
                });
                widget.optionOneTapped();

              },
              child: Container(
                decoration: BoxDecoration(
                  color: _isSelectedOption1
                      ? (widget.primaryColor ?? Styles.kPrimaryColor)
                      : Colors.white,
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(widget.customRadius ??  20),
                    bottomLeft: Radius.circular(widget.customRadius ??  20),
                  ),
                ),
                padding:  EdgeInsets.symmetric(vertical: widget.customVerticalPadding ?? 12),
                child: Center(
                  child: Text(
                    widget.textOne,
                    style: !_isSelectedOption1
                        ? kMediumSemiBold.copyWith(color: Styles.kPrimaryColor)
                        : kMediumSemiBold.copyWith(color: Styles.kLightBgColor),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectedOption1 = false;
                });
                widget.optionTwoTapped();

              },
              child: Container(
                decoration: BoxDecoration(
                  color: !_isSelectedOption1
                      ? widget.primaryColor ?? Styles.kPrimaryColor
                      : Colors.white,
                  borderRadius:  BorderRadius.only(
                    topRight: Radius.circular(widget.customRadius ?? 20),
                    bottomRight: Radius.circular(widget.customRadius ?? 20),
                  ),
                ),
                padding:  EdgeInsets.symmetric(
                  vertical: widget.customVerticalPadding ?? 12,
                ),
                child: Center(
                  child: Text(
                    widget.textTwo,
                    style: TextStyle(
                      color: !_isSelectedOption1
                          ? Colors.white
                          : (widget.primaryColor ?? Styles.kPrimaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

