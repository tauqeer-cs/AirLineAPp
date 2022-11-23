import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/meals_fee_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsFeePayment extends StatefulWidget {
  final bool isDeparture;

  const MealsFeePayment({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  State<MealsFeePayment> createState() => _MealsFeePaymentState();
}

class _MealsFeePaymentState extends State<MealsFeePayment> {

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return Column(
      children: [
        PriceRow(
          child1: Text("Meals", style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            amount:
                filter?.numberPerson.getTotalMealPartial(widget.isDeparture),
          ),
        ),
        MealsFeeDetailPayment(isDeparture: widget.isDeparture),
      ],
    );
  }
}
