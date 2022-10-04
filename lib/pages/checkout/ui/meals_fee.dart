import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/fares_and_bundles_detail.dart';
import 'package:app/pages/checkout/ui/meals_fee_detail.dart';
import 'package:app/pages/checkout/ui/seats_fee_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

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
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          title: Row(
            children: [
              Text(
                "- Meals",
                style: kLargeMedium,
              ),
              kHorizontalSpacerSmall,
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              Spacer(),
              MoneyWidget(amount:filter?.numberPerson.getTotalMealPartial(widget.isDeparture)),
            ],
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
