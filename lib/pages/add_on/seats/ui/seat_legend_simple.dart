import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/theme.dart';

enum SeatAvailableLegend {
  preferred("Preferred Seat", Color.fromRGBO(215, 189, 228, 1),'seatsSelection.preferredSeat'),
  standard("Standard Seat", Color.fromRGBO(126, 148, 208, 1),'seatsSelection.standardSeat'),
  unavailable("Unavailable", Color.fromRGBO(204, 204, 204, 1),'seatsSelection.unavailable');

  const SeatAvailableLegend(this.name, this.color,this.key);

  final String name;
  final Color color;
  final String key;
}

class SeatLegendSimple extends StatelessWidget {
  const SeatLegendSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacerMini,
        Text('seatTypes'.tr(), style: kMediumRegular),
        kVerticalSpacerSmall,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...(SeatAvailableLegend.values).map(
              (e) {
                return SizedBox(
                  width: 0.4.sw,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: e.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      kHorizontalSpacerMini,
                      Flexible(
                          child: Text(
                        e.key.tr(),
                        style: kSmallRegular,
                      ))
                    ],
                  ),
                );
              },
            ).toList(),

          ],
        ),
      ],
    );
  }
}
