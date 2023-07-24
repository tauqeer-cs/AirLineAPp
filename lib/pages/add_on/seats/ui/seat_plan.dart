import 'dart:developer';

import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/add_on/seats/ui/seat_row.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../models/number_person.dart';
import '../../../../widgets/app_money_widget.dart';

class SeatPlan extends StatelessWidget {
  const SeatPlan(
      {Key? key,
      this.moveToTop,
      this.moveToBottom,
      this.isManageBooking = false})
      : super(key: key);
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;

  final bool isManageBooking;

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    var flightSeats = bookingState.verifyResponse?.flightSeat;

    var isDeparture = true;
    List<InboundSeat>? inboundSeats;
    ManageBookingCubit? manageBookingCubit;

    if (isManageBooking == true) {
      var bloc = context.watch<ManageBookingCubit>();
      manageBookingCubit = bloc;

      flightSeats = bloc.state.flightSeats;
      isDeparture = bloc.state.seatDeparture;
    } else {
      isDeparture = context.watch<IsDepartureCubit>().state;
    }
    inboundSeats = isDeparture ? flightSeats?.outbound : flightSeats?.inbound;
    final rows = inboundSeats
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    final firstRow = rows?.firstOrNull;
    Map<num?, Color>? mapColor;
    List<Bundle> legends;
    if (isManageBooking) {
      var currentState = context.watch<ManageBookingCubit>().state;

      /*
      legends = isDeparture
          ? currentState.flightSeats?.outbound ?? []
          : currentState.flightSeats?.inbound ?? [];
*/

      legends = isDeparture ? [] : [];
    } else {
      mapColor = isDeparture
          ? bookingState.departureColorMapping
          : bookingState.returnColorMapping;

      legends = isDeparture
          ? bookingState.verifyResponse?.flightSSR?.seatGroup?.outbound ?? []
          : bookingState.verifyResponse?.flightSSR?.seatGroup?.inbound ?? [];
    }

    if (firstRow == null) return const SizedBox();
    return  Container(
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
            bool isSeatSeparated = row.seats?.first.serviceCode !=
                previousRow?.seats?.first.serviceCode;
            Bundle? bundle;
            num? newPrice;

            if (isManageBooking) {
              if (isSeatSeparated == true) {
                print('');

                try {
                  newPrice = row.seats?.first.seatPriceOffers?.first.amount;
                } catch (e) {
                  print('');
                }
              }
            }

            for (Seats seat in row.seats ?? []) {
              bundle = legends.firstWhereOrNull(
                  (element) => element.ssrCode == seat.serviceCode);
              if (bundle?.finalAmount != null && bundle?.finalAmount != 0)
                break;
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
                  if (isManageBooking) ...[
                    if (isSeatSeparated && newPrice != null)
                      Column(
                        children: [
                          kVerticalSpacerSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 1,
                                child: ArrowSVG(
                                  assetName:
                                      'assets/images/svg/seats_arrow_left.svg',
                                  color: row.seats?.first.toColor,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SeatPrice(
                                  amount: newPrice,
                                  currency: row.seats?.first.seatPriceOffers
                                      ?.firstOrNull?.currency,
                                ),
                              ),
                              Expanded(
                                child: ArrowSVG(
                                  assetName:
                                      'assets/images/svg/seats_arrow_right.svg',
                                  color: row.seats?.first.toColor,
                                ),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                          kVerticalSpacerSmall,
                        ],
                      ),
                  ] else ...[
                    if (isSeatSeparated && bundle != null)
                      Column(
                        children: [
                          kVerticalSpacerSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 1,
                                child: ArrowSVG(
                                  assetName:
                                      'assets/images/svg/seats_arrow_left.svg',
                                  color: row.seats?.first.toColor,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: (bundle.ssrCode ?? '').isEmpty
                                    ? Center(
                                        child: Text(
                                          "noData".tr(),
                                          style: kLargeHeavy,
                                        ),
                                      )
                                    : SeatPrice(
                                        amount: bundle.finalAmount,
                                        currency: row
                                            .seats
                                            ?.first
                                            .seatPriceOffers
                                            ?.firstOrNull
                                            ?.currency,
                                      ),
                              ),
                              Expanded(
                                child: ArrowSVG(
                                  assetName:
                                      'assets/images/svg/seats_arrow_right.svg',
                                  color: row.seats?.first.toColor,
                                ),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                          kVerticalSpacerSmall,
                        ],
                      ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 1, child: SizedBox()),
                      ...(row.seats ?? []).map((e) {
                        return (e.serviceCode ?? '').isEmpty
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
                                  isManageBooking: isManageBooking,
                                ),
                              );
                      }).toList(),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          kVerticalSpacer,
          if (isManageBooking) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),
            kVerticalSpacerSmall,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Text(
                    'seatTotal'.tr(),
                    style: kHugeSemiBold.copyWith(color: Styles.kTextColor),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  MoneyWidget(
                    amount:
                        manageBookingCubit?.notConfirmedSeatsTotalPrice ?? 0.0,
                    isDense: true,
                    isNormalMYR: true,
                  ),
                ],
              ),
            ),
            kVerticalSpacerSmall,
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: manageBookingCubit?.hasAnySeatChanged == false
                        ? null
                        : () {
                            manageBookingCubit?.seatConfirmSeatChange();

                            manageBookingCubit?.changeSelectedAddOnOption(
                                AddonType.seat,
                                toNull: true);
                          },
                    child: Text('selectDateView.confirm'.tr()),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            kVerticalSpacer,
          ],
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
    final bookingState = context.watch<BookingCubit>().state;
    var currentcy2 = bookingState.selectedDeparture?.fareTypeWithTaxDetails
            ?.first.fareInfoWithTaxDetails?.first.originalCurrency ??
        'MYR';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${currency ?? currentcy2} ",
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
