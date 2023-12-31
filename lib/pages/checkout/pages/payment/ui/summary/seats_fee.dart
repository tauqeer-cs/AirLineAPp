import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/seats_fee_detail.dart';
import 'package:app/theme/typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsFeePayment extends StatefulWidget {
  final bool isDeparture;
  final String? currency;

  const SeatsFeePayment({Key? key, required this.isDeparture, this.currency})
      : super(key: key);

  @override
  State<SeatsFeePayment> createState() => _SeatsFeePaymentState();
}

class _SeatsFeePaymentState extends State<SeatsFeePayment> {
  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return Column(
      children: [
        PriceRow(
          child1:  Text('priceSection.seats'.tr(), style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            currency: widget.currency,
            amount:
                filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture),
          ),
        ),
        SeatsFeeDetailPayment(isDeparture: widget.isDeparture),
      ],
    );
  }
}
