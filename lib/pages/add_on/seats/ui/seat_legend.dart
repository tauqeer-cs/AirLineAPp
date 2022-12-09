import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatsLegend extends StatelessWidget {
  const SeatsLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    final seatsSSR = bookingState.verifyResponse?.flightSSR?.seatGroup;
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final availableType = isDeparture ? seatsSSR?.outbound : seatsSSR?.inbound;
    final mapColor = isDeparture
        ? bookingState.departureColorMapping
        : bookingState.returnColorMapping;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacerMini,
        const Text("Seat Types", style: kLargeHeavy),
        kVerticalSpacerSmall,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...(availableType ?? []).map(
              (e) {
                return SizedBox(
                  width: 0.4.sw,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: (mapColor ?? {})[e.serviceID],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      kHorizontalSpacerMini,
                      Flexible(child: Text(e.description?.camelCase() ?? "", style: kSmallRegular,))
                    ],
                  ),
                );
              },
            ).toList(),
            SizedBox(
              width: 0.4.sw,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  kHorizontalSpacerMini,
                  const Flexible(child: Text("Unavailable", style: kSmallRegular,))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
