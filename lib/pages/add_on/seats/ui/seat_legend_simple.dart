import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/theme.dart';

enum SeatAvailableLegend {
  preferred("Preferred Seat", Color.fromRGBO(215, 189, 228, 1)),
  standard("Standard Seat", Color.fromRGBO(126, 148, 208, 1)),
  unavailable("Unavailable", Color.fromRGBO(204, 204, 204, 1));

  const SeatAvailableLegend(this.name, this.color);

  final String name;
  final Color color;
}

class SeatLegendSimple extends StatelessWidget {
  const SeatLegendSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacerMini,
        const Text("Seat Types", style: kMediumRegular),
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
                        e.name,
                        style: kSmallRegular,
                      ))
                    ],
                  ),
                );
              },
            ).toList(),
            // SizedBox(
            //   width: 0.4.sw,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 20,
            //         width: 20,
            //         child: DecoratedBox(
            //           decoration: BoxDecoration(
            //             color: Colors.grey,
            //             borderRadius: BorderRadius.circular(4),
            //           ),
            //         ),
            //       ),
            //       kHorizontalSpacerMini,
            //       const Flexible(
            //           child: Text(
            //         "Unavailable",
            //         style: kSmallRegular,
            //       ))
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   width: 0.4.sw,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 20,
            //         width: 20,
            //         child: DecoratedBox(
            //           decoration: BoxDecoration(
            //             color: Colors.purpleAccent,
            //             borderRadius: BorderRadius.circular(4),
            //           ),
            //         ),
            //       ),
            //       kHorizontalSpacerMini,
            //       const Flexible(child: Text("No Price Data", style: kSmallRegular,))
            //     ],
            //   ),
            // )
          ],
        ),
      ],
    );
  }
}
