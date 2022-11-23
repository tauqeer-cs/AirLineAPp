import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/baggage_fee_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BaggageFeePayment extends StatefulWidget {
  final bool isDeparture;
  const BaggageFeePayment({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<BaggageFeePayment> createState() => _BaggageFeePaymentState();
}

class _BaggageFeePaymentState extends State<BaggageFeePayment> {

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return Column(
      children: [
        kVerticalSpacer,
        PriceRow(
          child1: Text("Baggage", style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            amount:filter?.numberPerson.getTotalBaggagePartial(widget.isDeparture),
          ),
        ),
        BaggageFeeDetailPayment(isDeparture: widget.isDeparture),
      ],
    );
  }
}
