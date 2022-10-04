import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsLegend extends StatelessWidget {
  const SeatsLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context
        .watch<BookingCubit>()
        .state;
    final seatsSSR = bookingState.verifyResponse
        ?.flightSSR
        ?.seatGroup;
    final isDeparture = context
        .watch<IsDepartureCubit>()
        .state;
    final availableType = isDeparture ? seatsSSR?.outbound : seatsSSR?.inbound;
    final mapColor = isDeparture ? bookingState.departureColorMapping : bookingState.returnColorMapping;
    print("available type ${availableType?.length}");
    return Wrap(
      spacing: 16,
      runSpacing: 5,
      children: (availableType ?? []).map(
            (e) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: (mapColor ?? {})[e.serviceID],
              ),
              kHorizontalSpacerMini,
              Text(e.description ?? "")
            ],
          );
        },
      ).toList(),
    );
  }
}
