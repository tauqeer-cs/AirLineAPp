import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/baggage_fee_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'insurance_fee_detail.dart';


class InsuarnceFeePayment extends StatefulWidget {
  final bool isDeparture;
  final bool isSports;
  final String? currency;

  const InsuarnceFeePayment({Key? key, required this.isDeparture, this.isSports = false, this.currency}) : super(key: key);

  @override
  State<InsuarnceFeePayment> createState() => _InsuarnceFeePaymentState();
}

class _InsuarnceFeePaymentState extends State<InsuarnceFeePayment> {

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final insurance = context.watch<InsuranceCubit>().state.totalInsurance();

    return Column(
      children: [
        kVerticalSpacer,
        PriceRow(
          child1: Text("insurance".tr(), style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            currency: widget.currency,
            amount:insurance,
          ),
        ),
        InsuranceFeeDetail(isDeparture: widget.isDeparture,
          currency: widget.currency,

        ),
      ],
    );
  }

  num? buildTotalBaggagePartial(FilterState? filter) {
    if(widget.isSports) {
      return filter?.numberPerson.getTotalSportsPartial(widget.isDeparture);
    }
    return filter?.numberPerson.getTotalBaggagePartial(widget.isDeparture);
  }
}
