import 'package:app/app/app_router.dart';
import 'package:app/pages/checkout/pages/select_meals/ui/available_meals.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MealSelections extends StatefulWidget {
  const MealSelections({Key? key}) : super(key: key);

  @override
  State<MealSelections> createState() => _MealSelectionsState();
}

class _MealSelectionsState extends State<MealSelections>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final widgets = <Widget>[
      kVerticalSpacerBig,
      const Text("Meals Selection ", style: kGiantHeavy),
      const PersonSelector(),
      kVerticalSpacer,
      const AvailableMeals(),
      kVerticalSpacer,
      const CheckoutSummary(),
      kVerticalSpacer,
      const AppDividerWidget(),
      kVerticalSpacer,
      const BookingSummary(),
      kVerticalSpacer,
      ElevatedButton(
        onPressed: () => context.router.push(const SelectBaggageRoute()),
        child: const Text("Continue"),
      ),
      kVerticalSpacer,
    ];
    return ListView.builder(
      itemBuilder: (context, index) => widgets[index],
      itemCount: widgets.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
