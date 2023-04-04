import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../theme/theme.dart';
import 'meals_fee_detail.dart';


class MealsFee extends StatefulWidget {
  final bool isDeparture;

  const MealsFee({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<MealsFee> createState() => _MealsFeeState();
}

class _MealsFeeState extends State<MealsFee> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final isPaymentPage = context.watch<IsPaymentPageCubit>().state;
    return Column(
      children: [
        kVerticalSpacer,
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Row(
            children: [
              Text(
                isPaymentPage ? "Meals" : "- Meals",
                style: kMediumHeavy,
              ),

              const Spacer(),
              MoneyWidgetCustom(
                fontWeight: FontWeight.w700,
                  amount: filter?.numberPerson
                      .getTotalMealPartial(widget.isDeparture)
              ),
            ],
          ),
        ),
        MealsFeeDetail(isDeparture: widget.isDeparture),
      ],
    );
  }
}
