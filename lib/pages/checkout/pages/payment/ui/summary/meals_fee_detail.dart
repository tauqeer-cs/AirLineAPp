import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes_detail.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsFeeDetailPayment extends StatelessWidget {
  final bool isDeparture;

  const MealsFeeDetailPayment({Key? key, required this.isDeparture})
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
              return SizedBox();
            }
            final passenger = passengersTypes.length > (e.numberOrder!.toInt())
                ? passengersTypes[e.numberOrder!.toInt()]
                : passengersTypes[0];
            final meals = isDeparture ? e.departureMeal : e.returnMeal;
            return meals.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${passenger.title} ${passenger.firstName}",
                        style: kMediumRegular,
                      ),
                      kVerticalSpacerMini,
                      ...meals
                          .map(
                            (meal) => PriceRow(
                              child1: Text(
                                meal.description ?? "",
                                style: kMediumRegular,
                              ),
                              child2: MoneyWidgetSummary(
                                amount: meal.amount,
                                isDense: true,
                                currency: meal.currencyCode,
                              ),
                            ),
                          )
                          .toList(),
                      kVerticalSpacerSmall,

                    ],
                  );
          },
        ).toList(),
      ],
    );
  }
}
