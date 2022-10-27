import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class MealsFeeDetail extends StatelessWidget {
  final bool isDeparture;

  const MealsFeeDetail({Key? key, required this.isDeparture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    return Column(
      children: [
        kVerticalSpacerSmall,
        AppDividerWidget(color: Styles.kTextColor),
        ...persons.map(
          (e) {
            final meals = isDeparture ? e.departureMeal : e.returnMeal;
            return meals.isEmpty
                ? SizedBox.shrink()
                : PriceContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${e.toString()} :",
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
                                        amount: meal.amount,
                                        isDense: true,
                                        currency: meal.currencyCode),
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
