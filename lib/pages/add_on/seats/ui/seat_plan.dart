import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/pages/add_on/seats/ui/seat_row.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatPlan extends StatelessWidget {
  const SeatPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    final flightSeats = bookingState.verifyResponse?.flightSeat;
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final inboundSeats =
        isDeparture ? flightSeats?.outbound : flightSeats?.inbound;

    final rows = inboundSeats
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    final firstRow = rows?.firstOrNull;
    final List<int> seatSeparations = [1, 2, 6, 11, 12, 15];

    if (firstRow == null) return const SizedBox();
    return Container(
      color: Styles.kDividerColor,
      child: Column(
        children: [
          kVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              ...(firstRow.seats ?? [])
                  .map((e) => Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            e.seatColumn ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
                  .toList(),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
          ...(rows ?? []).map((row) {
            bool isSeatSeparated = seatSeparations.contains(row.rowNumber);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  if (isSeatSeparated)
                    Column(
                      children: [
                        kVerticalSpacerSmall,
                        SeatPrice(
                          amount: row
                              .seats?.first.seatPriceOffers?.firstOrNull?.amount
                              ?.toDouble(),
                          currency: row.seats?.first.seatPriceOffers
                              ?.firstOrNull?.currency,
                        ),
                        kVerticalSpacerSmall,
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 1, child: SizedBox()),
                      ...(row.seats ?? []).map((e) {
                        return e.serviceId == 0
                            ? Expanded(
                                flex: 1,
                                child: Center(
                                    child: Text("${row.rowNumber ?? 0}")))
                            : Expanded(
                                flex: 1,
                                child: SeatRow(seats: e),
                              );
                      }).toList(),
                      const Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                ],
              ),
            );
          }),
          kVerticalSpacer,
        ],
      ),
    );
  }
}

class SeatPrice extends StatelessWidget {
  final num? amount;
  final String? currency;

  const SeatPrice({
    Key? key,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${currency ?? 'MYR'} ",
          style: kMediumHeavy.copyWith(height: 1.5, fontSize: 10),
        ),
        kHorizontalSpacerMini,
        Text(
          NumberUtils.formatNumber(amount?.toDouble()),
          style: kHeaderHeavy.copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
