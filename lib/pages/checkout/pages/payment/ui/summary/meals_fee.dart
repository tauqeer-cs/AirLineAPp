import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/meals_fee_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsFeePayment extends StatefulWidget {
  final bool isDeparture;
  final String? currency;

  const MealsFeePayment({Key? key, required this.isDeparture, this.currency})
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
        kVerticalSpacer,
        PriceRow(
          child1:  Text('priceSection.mealsTitle'.tr(), style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            currency: widget.currency,

            amount:
                filter?.numberPerson.getTotalMealPartial(widget.isDeparture),
          ),
        ),
        MealsFeeDetailPayment(isDeparture: widget.isDeparture),
      ],
    );
  }
}
