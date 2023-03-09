import 'dart:developer';

import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/add_on/seats/ui/seat_row.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SeatPlan extends StatelessWidget {
  const SeatPlan({Key? key, this.moveToTop, this.moveToBottom})
      : super(key: key);
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;

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
    final mapColor = isDeparture
        ? bookingState.departureColorMapping
        : bookingState.returnColorMapping;
    final legends = isDeparture
        ? bookingState.verifyResponse?.flightSSR?.seatGroup?.outbound ?? []
        : bookingState.verifyResponse?.flightSSR?.seatGroup?.inbound ?? [];

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
          ...(rows ?? []).asMap().entries.map((entry) {
            int index = entry.key;
            Rows row = entry.value;
            Rows? previousRow = index == 0 ? null : rows?[index - 1];
            bool isSeatSeparated = row.seats?.first.serviceId !=
                previousRow?.seats?.first.serviceId;
            Bundle? bundle;
            for (Seats seat in row.seats ?? []) {
              bundle = legends.firstWhereOrNull(
                  (element) => element.serviceID == seat.serviceId);
              if (bundle?.finalAmount != null && bundle?.finalAmount != 0) break;
            }

            // final bundle = legends.firstWhereOrNull(
            //     (element) => element.serviceID == row.seats?.first.serviceId);
            if (bundle?.finalAmount == null) {
              log("final amount ${bundle?.toJson()}");
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  kVerticalSpacerSmall,
                  if (isSeatSeparated && bundle != null)
                    Column(
                      children: [
                        kVerticalSpacerSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            ArrowSVG(
                              assetName:
                                  'assets/images/svg/seats_arrow_left.svg',
                              color: mapColor?[row.seats?.first.serviceId] ??
                                  Colors.purpleAccent,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: bundle?.finalAmount == null
                                  ? Text("No Data")
                                  : SeatPrice(
                                      amount: bundle?.finalAmount ?? 0,
                                      currency: row.seats?.first.seatPriceOffers
                                          ?.firstOrNull?.currency,
                                    ),
                            ),
                            ArrowSVG(
                              assetName:
                                  'assets/images/svg/seats_arrow_right.svg',
                              color: mapColor?[row.seats?.first.serviceId] ??
                                  Colors.purpleAccent,
                            ),
                            const Expanded(flex: 1, child: SizedBox()),
                          ],
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
                                  child: Text("${row.rowNumber ?? 0}"),
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: SeatRow(
                                  seats: e,
                                  moveToTop: () {
                                    moveToTop?.call();
                                  },
                                  moveToBottom: () {
                                    moveToBottom?.call();
                                  },
                                ),
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

class ArrowSVG extends StatelessWidget {
  final String assetName;
  final Color? color;

  const ArrowSVG({Key? key, required this.assetName, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SvgPicture.asset(assetName, color: color),
    );
  }
}
