import 'package:flutter/material.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';

class FlightInto extends StatelessWidget {
  final String label;
  final String timeString;
  final String location;

  final bool showDisabled;

  const FlightInto({
    Key? key,
    required this.label,
    required this.timeString,
    required this.location,
    this.showDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: kSmallHeavy.copyWith(
              color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor),
        ),
        Text(
          timeString,
          style: kSmallMedium.copyWith(
              color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor),
        ),
        Text(
          location,
          maxLines: 4,
          style: kSmallMedium.copyWith(
              color: showDisabled ? Styles.kDisabledGrey : Styles.kTextColor),

          //icoFlightBlack
        ),
      ],
    );
  }
}
