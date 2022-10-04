import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seat_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatRows extends StatelessWidget {
  const SeatRows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    final flightSeats = bookingState.verifyResponse?.flightSeat;
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final inboundSeats =
        isDeparture ? flightSeats?.outbound : flightSeats?.inbound;
    final mapColor = isDeparture
        ? bookingState.departureColorMapping
        : bookingState.returnColorMapping;

    final rows = inboundSeats
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    final firstRow = rows?.firstOrNull;
    if (firstRow == null) return SizedBox();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: SizedBox()),
            ...(firstRow.seats ?? [])
                .map((e) => Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(e.seatColumn ?? ""),
                      ),
                    ))
                .toList(),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        kVerticalSpacer,
        ...(rows ?? []).map((row) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 1, child: Text("${row.rowNumber ?? 0}")),
                  ...(row.seats ?? [])
                      .map((e) => e.serviceId == 0
                          ? Expanded(flex: 1, child: SizedBox())
                          : Expanded(
                              flex: 1,
                              child: SeatWidget(mapColor: mapColor, seats: e,),
                            ))
                      .toList(),
                  Expanded(
                      flex: 1,
                      child: Text(
                        "${row.rowNumber ?? 0}",
                        textAlign: TextAlign.end,
                      )),
                ],
              ),
            )),
        kVerticalSpacer,

      ],
    );
  }
}

