import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/baggage_fee_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaggageFeePayment extends StatefulWidget {
  final bool isDeparture;
  final bool isSports;

  const BaggageFeePayment(
      {Key? key, required this.isDeparture, this.isSports = false})
      : super(key: key);

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
          child1: Text(widget.isSports ? 'priceSection.sportsEquipmentTitle'.tr() : "baggage".tr(),
              style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            isSports: widget.isSports,
            amount: buildTotalBaggagePartial(filter),
          ),
        ),
        BaggageFeeDetailPayment(
          isDeparture: widget.isDeparture,
          isSports: widget.isSports,
        ),
      ],
    );
  }

  num? buildTotalBaggagePartial(FilterState? filter) {
    if (widget.isSports) {
      return filter?.numberPerson.getTotalSportsPartial(widget.isDeparture);
    }
    return filter?.numberPerson.getTotalBaggagePartial(widget.isDeparture);
  }
}
