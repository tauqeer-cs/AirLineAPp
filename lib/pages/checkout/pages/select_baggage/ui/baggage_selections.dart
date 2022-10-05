import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/pages/checkout/pages/select_baggage/ui/available_baggage.dart';
import 'package:app/pages/checkout/pages/select_baggage/ui/baggage_notice.dart';
import 'package:app/pages/checkout/pages/select_bundle/ui/bundle_card.dart';
import 'package:app/pages/checkout/pages/select_meals/ui/available_meals.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/remove_seat_selection.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seat_rows.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seats_legend.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaggageSelections extends StatefulWidget {
  const BaggageSelections({Key? key}) : super(key: key);

  @override
  State<BaggageSelections> createState() => _BaggageSelectionsState();
}

class _BaggageSelectionsState extends State<BaggageSelections>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final widgets = <Widget>[
      kVerticalSpacerBig,
      Text("Baggage", style: kGiantHeavy),
      PersonSelector(),
      kVerticalSpacer,
      AvailableBaggage(),
      kVerticalSpacer,
      BaggageNotice(),
      kVerticalSpacer,
      CheckoutSummary(),
      kVerticalSpacer,
      AppDividerWidget(),
      kVerticalSpacer,
      BookingSummary(),
      kVerticalSpacer,
      ElevatedButton(
        onPressed:() => context.router.push(BookingDetailsRoute()),
        child: Text("Continue"),
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
