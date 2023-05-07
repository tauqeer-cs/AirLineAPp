import 'dart:developer';

import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../../../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../../../../utils/constant_utils.dart';

class FeeAndTaxesDetailPayment extends StatelessWidget {
  final bool isDeparture;
  final String? currency;

  const FeeAndTaxesDetailPayment({Key? key, required this.isDeparture, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.watch<BookingCubit>().state;

    final segment = isDeparture
        ? context.watch<BookingCubit>().state.selectedDeparture
        : context.watch<BookingCubit>().state.selectedReturn;
    final info = segment?.fareTypeWithTaxDetails?.firstOrNull
        ?.fareInfoWithTaxDetails?.firstOrNull;
    final bookingState = context.read<BookingCubit>().state;
    final List<ApplicationTaxDetailBinds>? taxes =
        info?.applicationTaxDetailBinds;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;
    final selectedFlight = isDeparture
        ? bookingState.selectedDeparture
        : bookingState.selectedReturn;
    if (taxes?.isEmpty ?? true) return const SizedBox();
    log(pnrRequest?.toJson().toString() ?? "");
    num discountTotal = 0;
    if(ConstantUtils.showPromoInFareBreakDown) {
      final filter = context.watch<SearchFlightCubit>().state.filterState;
      var discountPercent = bookingCubit.selectedDeparture!.discountPCT;
      if (filter?.promoCode != null &&
          discountPercent != null &&
          (discountPercent > 0)) {
        discountTotal = 1;
        var a =
            bookingCubit.selectedDeparture!.beforeDiscountTotalAmtWithInfantSSR;
        var b = bookingCubit.selectedDeparture!.totalSegmentFareAmtWithInfantSSR;

        discountTotal = a! - b!;
      }
    }


    return Column(
      children: [
        kVerticalSpacerSmall,
        ...(pnrRequest?.passengers ?? []).map((e) {
          final price = selectedFlight?.getPrice(e.paxType ?? "");
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: PriceRow(
              child1: Text(
                "${e.titleToShow} ${e.firstName}",
                style: kMediumRegular,
              ),
              child2: MoneyWidgetSummary(
                currency: currency,
                amount: price,
                isDense: true,
              ),
            ),
          );
        }).toList(),

        if(ConstantUtils.showPromoInFareBreakDown && discountTotal > 0) ... [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: PriceRow(
              child1:  Text(
                'promo'.tr(),
                style: kMediumRegular,
              ),
              child2: MoneyWidgetSummary(
                currency: currency,
                amount: discountTotal,
                isDense: true,
                  isNegative : true,
              ),
            ),
          )
        ],
        kVerticalSpacerSmall,
      ],
    );
  }
}

class PriceContainer extends StatelessWidget {
  final Widget child;

  const PriceContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: child,
    );
  }
}
