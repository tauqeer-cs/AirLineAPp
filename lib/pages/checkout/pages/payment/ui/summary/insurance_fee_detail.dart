import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsuranceFeeDetail extends StatelessWidget {
  final bool isDeparture;
  final String? currency;

  const InsuranceFeeDetail({Key? key, required this.isDeparture,this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final passengers = context.watch<InsuranceCubit>().state.passengersWithOutInfants;

    final bookingState = context.watch<BookingCubit>().state;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;
    return Column(
      children: [
        kVerticalSpacerSmall,
        ...passengers.map(
          (e) {

            return e.getInsurance == null
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${e.title} ${e.firstName}",
                        style: kMediumRegular,
                      ),
                      kVerticalSpacerMini,
                      PriceRow(
                        child1: Text(
                          e.getInsurance?.name ?? "",
                          style: kMediumRegular,
                        ),
                        child2: MoneyWidgetSummary(
                          amount: e.getInsurance?.price,
                          isDense: true,
                          currency: currency ?? "MYR",
                        ),
                      ),
                      kVerticalSpacerSmall,
                    ],
                  );
          },
        ).toList(),
      ],
    );
  }
}
