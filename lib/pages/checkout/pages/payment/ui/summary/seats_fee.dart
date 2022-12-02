import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/seats_fee_detail.dart';
import 'package:app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsFeePayment extends StatefulWidget {
  final bool isDeparture;

  const SeatsFeePayment({Key? key, required this.isDeparture})
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
          child1: const Text("Seats", style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            amount:
                filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture),
          ),
        ),
        SeatsFeeDetailPayment(isDeparture: widget.isDeparture),
      ],
    );
  }
}
