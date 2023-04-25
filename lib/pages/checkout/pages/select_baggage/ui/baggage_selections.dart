import 'package:app/app/app_router.dart';
import 'package:app/pages/checkout/pages/select_baggage/ui/available_baggage.dart';
import 'package:app/pages/checkout/pages/select_baggage/ui/baggage_notice.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
      Text("baggage".tr(), style: kGiantHeavy),
      const PersonSelector(),
      kVerticalSpacer,
      const AvailableBaggage(),
      kVerticalSpacer,
      const BaggageNotice(),
      kVerticalSpacer,
      const CheckoutSummary(),
      kVerticalSpacer,
      const AppDividerWidget(),
      kVerticalSpacer,
      const BookingSummary(),
      kVerticalSpacer,
      ElevatedButton(
        onPressed: () => context.router.push(
          const BookingDetailsRoute(),
        ),
        child: Text("continue".tr()),
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
