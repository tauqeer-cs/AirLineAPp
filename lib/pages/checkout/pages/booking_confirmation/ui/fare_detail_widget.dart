import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/booking/booking_cubit.dart';
import '../../payment/ui/summary/money_widget_summary.dart';
import '../../payment/ui/summary/price_row.dart';

class FareDetailWidget extends StatelessWidget {
  final bool isDeparture;
  final String currency;

  const FareDetailWidget({Key? key, required this.isDeparture, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passengers = context
            .watch<ConfirmationCubit>()
            .state
            .confirmationModel
            ?.value
            ?.passengers ??
        [];
    final bookingState = context.read<BookingCubit>().state;

    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;

    final selectedFlight = isDeparture
        ? bookingState.selectedDeparture
        : bookingState.selectedReturn;

    return Column(
      children: [

        kVerticalSpacerMini,

        if(passengers.isNotEmpty) ... [
          ...(pnrRequest?.passengers ?? []).map((e) {
            final price = selectedFlight?.getPriceWithoutTax(e.paxType ?? "",isDeparture);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: PriceRow(
                child1: Text(
                  "${e.titleToShow?.toUpperCase()} ${e.firstName?.toUpperCase()} ${e.lastName?.toUpperCase()} (${'ticket'.tr()})",
                  style: kMediumMedium,
                ),
                child2: MoneyWidgetSummary(
                  currency: currency,
                  amount: price,
                  isDense: true,
                ),
              ),
            );
          }).toList(),
        ],


      ],
    );
  }
}
