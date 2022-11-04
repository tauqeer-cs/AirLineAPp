import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class SeatLegend extends StatelessWidget {
  const SeatLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final legends = {
      "Preferred Seat": const Color.fromRGBO(126, 213, 245, 1),
      "Standard Seat": const Color.fromRGBO(247, 108, 6, 1),
      "Unavailable": const Color.fromRGBO(141, 153, 174, 1),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        const Text("Seating options", style: kMediumMedium),
        kVerticalSpacer,
        Wrap(
          runSpacing: 5.0,
          spacing: 9,
          children: legends.entries.map(
            (e) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: e.value,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Text(e.key, style: kSmallRegular),
                ],
              );
            },
          ).toList(),
        ),
        kVerticalSpacer,
      ],
    );
  }
}
