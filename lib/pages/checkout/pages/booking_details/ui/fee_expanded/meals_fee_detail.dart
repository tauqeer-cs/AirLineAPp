import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fee_and_taxes_detail.dart';

class MealsFeeDetail extends StatelessWidget {
  final bool isDeparture;

  const MealsFeeDetail({Key? key, required this.isDeparture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    var currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    return Column(
      children: [
        ...persons.map(
          (e) {
            final meals = isDeparture ? e.departureMeal : e.returnMeal;
            return meals.isEmpty
                ? const SizedBox.shrink()
                : PriceContainer(
                    padding: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${e.generateText(filter?.numberPerson)} :",
                          style: kSmallRegular,
                        ),
                        kVerticalSpacerMini,
                        ...meals
                            .map(
                              (meal) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        meal.description ?? "",
                                        style: kSmallRegular.copyWith(
                                            color: Styles.kSubTextColor),
                                      ),
                                    ),
                                    kHorizontalSpacerMini,
                                    MoneyWidgetSmall(
                                        amount: meal.finalAmount,
                                        isDense: true,
                                        currency: currency),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}
