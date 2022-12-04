import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaggageFeeDetailPayment extends StatelessWidget {
  final bool isDeparture;

  const BaggageFeeDetailPayment({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    final bookingState = context.watch<BookingCubit>().state;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;
    final passengers = pnrRequest?.passengers ?? [];
    return Column(
      children: [
        kVerticalSpacerSmall,
        ...persons.map(
          (e) {
            final passengersTypes = passengers
                .where((element) => element.paxType == e.peopleType?.code)
                .toList();
            if (passengersTypes.isEmpty || e.numberOrder == null) {
              return const SizedBox();
            }
            final passenger = passengersTypes.length > (e.numberOrder!.toInt())
                ? passengersTypes[e.numberOrder!.toInt()]
                : passengersTypes[0];
            final bundle = isDeparture ? e.departureBaggage : e.returnBaggage;
            return bundle?.amount == null
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      PriceRow(
                        child1: Text(
                          "${passenger.title} ${passenger.firstName}\n${e.generateText(filter?.numberPerson)} : ${bundle?.description ?? 'No Bundle'}",
                          style: kMediumRegular.copyWith(
                              color: Styles.kSubTextColor),
                        ),
                        child2: MoneyWidgetSummary(
                            amount: bundle?.finalAmount,
                            isDense: true,
                            currency: bundle?.currencyCode),
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
