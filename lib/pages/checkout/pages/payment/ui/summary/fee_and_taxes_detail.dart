import 'dart:developer';

import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class FeeAndTaxesDetailPayment extends StatelessWidget {
  final bool isDeparture;

  const FeeAndTaxesDetailPayment({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final segment = isDeparture
        ? context.watch<BookingCubit>().state.selectedDeparture
        : context.watch<BookingCubit>().state.selectedReturn;
    final info = segment?.fareTypeWithTaxDetails?.firstOrNull
        ?.fareInfoWithTaxDetails?.firstOrNull;
    final bookingState = context.read<BookingCubit>().state;
    final List<ApplicationTaxDetailBinds>? taxes =
        info?.applicationTaxDetailBinds;
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;
    final selectedFlight = isDeparture
        ? bookingState.selectedDeparture
        : bookingState.selectedReturn;
    if (taxes?.isEmpty ?? true) return const SizedBox();
    log(pnrRequest?.toJson().toString() ?? "");
    return Column(
      children: [
        kVerticalSpacerSmall,
        ...(pnrRequest?.passengers ?? []).map((e) {
          final price = selectedFlight?.getPrice(e.paxType ?? "");
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PriceRow(
              child1: Text(
                "${e.title} ${e.firstName}",
                style: kMediumRegular,
              ),
              child2: MoneyWidgetSummary(
                amount: price,
                isDense: true,
              ),
            ),
          );
        }).toList(),
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
