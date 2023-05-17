import 'package:flutter/material.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';

class PlaneWithTime extends StatelessWidget {
  final String time;
  final bool showDisabled;

  const PlaneWithTime({
    Key? key,
    required this.time,
    this.showDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          showDisabled
              ? "assets/images/icons/icoFlightDisabled.png"
              : "assets/images/icons/icoFlightBlack.png",
          width: 32,
          height: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            time,
            style: kTinyRegular.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

