import 'package:flutter/material.dart';

import '../theme/styles.dart';
import '../theme/typography.dart';


class CustomSegmentControl extends StatefulWidget {
  final Color? primaryColor;
  final VoidCallback optionOneTapped;
  final VoidCallback optionTwoTapped;

  final String textOne;
  final String textTwo;

  const CustomSegmentControl(
      {super.key,
        this.primaryColor,
        required this.optionOneTapped,
        required this.optionTwoTapped,
        required this.textOne,
        required this.textTwo});

  @override
  _CustomSegmentControlState createState() => _CustomSegmentControlState();
}

class _CustomSegmentControlState extends State<CustomSegmentControl> {
  bool _isSelectedOption1 = true;

  //                style: kMediumSemiBold.copyWith(color: Styles.kPrimaryColor),
  //                style: kMediumSemiBold,
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: widget.primaryColor ?? Styles.kPrimaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectedOption1 = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _isSelectedOption1
                      ? (widget.primaryColor ?? Styles.kPrimaryColor)
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
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
              },
              child: Container(
                decoration: BoxDecoration(
                  color: !_isSelectedOption1
                      ? widget.primaryColor ?? Styles.kPrimaryColor
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
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

