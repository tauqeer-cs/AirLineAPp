import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/typography.dart';

class BookingReferenceLabel extends StatelessWidget {

  final String? refText;

  const BookingReferenceLabel({Key? key, this.refText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            'bookReference'.tr(),
            style: kMediumRegular,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            refText ?? '',
            style: kHugeHeavy,
          ),
        ),
      ],
    );
  }
}
