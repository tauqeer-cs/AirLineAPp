import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/checkout/ui/meals_fee_detail.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class MealsFee extends StatefulWidget {
  final bool isDeparture;
  final String? currency;

  const MealsFee({Key? key, required this.isDeparture, this.currency}) : super(key: key);

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
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  isPaymentPage ? "Meals" : "- Meals",
                  style: kMediumRegular,
                ),
                kHorizontalSpacerSmall,
                Icon(
                  isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
                const Spacer(),
                MoneyWidgetSmall(
                  currency: widget.currency,
                    amount: filter?.numberPerson
                        .getTotalMealPartial(widget.isDeparture)),
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: MealsFeeDetail(isDeparture: widget.isDeparture),
        ),
      ],
    );
  }
}
