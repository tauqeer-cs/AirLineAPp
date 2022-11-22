import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        const Text("Seating options", style: kMediumMedium),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            ...(availableType ?? []).map(
              (e) {
                return SizedBox(
                  width: 150,
                  height: 40,
                  child: Row(
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
                      Flexible(child: Text(e.description ?? ""))
                    ],
                  ),
                );
              },
            ).toList(),
            SizedBox(
              width: 150,
              height: 40,
              child: Row(
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
                  const Flexible(child: Text("Unavailable"))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
