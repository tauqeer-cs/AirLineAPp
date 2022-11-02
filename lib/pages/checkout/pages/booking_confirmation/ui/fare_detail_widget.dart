import 'package:app/models/confirmation_model.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';

class FareDetailWidget extends StatelessWidget {
  final FareAndBundle fareAndBundle;

  const FareDetailWidget({Key? key, required this.fareAndBundle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
                "${fareAndBundle.title} ${fareAndBundle.givenName} ${fareAndBundle.surName}"),
            Spacer(),
            // MoneyWidget(
            //   currency: fareAndBundle.currency,
            //   amount: fareAndBundle.fareAmount,
            //   isDense: true,
            // ),
            //
            // kVerticalSpacer,
          ],
        ),
        kVerticalSpacerMini,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: (fareAndBundle.bundleItems ?? [])
                .map((f) => Row(
              children: [
                Text(
                    "${f.bundleName}"),
                // Spacer(),
                // MoneyWidget(
                //   currency: fareAndBundle.currency,
                //   amount: fareAndBundle.fareAmount,
                //   isDense: true,
                // ),
              ],
            ))
                .toList(),
          ),
        ),
        kVerticalSpacerSmall,
      ],
    );
  }
}
