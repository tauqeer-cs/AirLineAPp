import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/wheelchair_fee_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WheelchairFeePayment extends StatefulWidget {
  final bool isDeparture;
  final bool isSports;

  const WheelchairFeePayment({Key? key, required this.isDeparture, this.isSports = false}) : super(key: key);

  @override
  State<WheelchairFeePayment> createState() => _WheelchairFeePaymentState();
}

class _WheelchairFeePaymentState extends State<WheelchairFeePayment> {

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return Column(
      children: [
        kVerticalSpacer,
        PriceRow(
          child1:  Text('wheelChairLabel'.tr(), style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            isSports: widget.isSports,
            amount:filter?.numberPerson.getTotalWheelChairPartial(widget.isDeparture),
          ),
        ),
        WheelchairFeeDetailPayment(isDeparture: widget.isDeparture,),
      ],
    );
  }


}
