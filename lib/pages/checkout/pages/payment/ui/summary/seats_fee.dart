import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/seats_fee_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SeatsFeePayment extends StatefulWidget {
  final bool isDeparture;
  const SeatsFeePayment({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<SeatsFeePayment> createState() => _SeatsFeePaymentState();
}

class _SeatsFeePaymentState extends State<SeatsFeePayment> {
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
              const Text(
                "- Seats",
                style: kMediumRegular,
              ),
              kHorizontalSpacerSmall,
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              const Spacer(),
              MoneyWidgetSmall(amount:filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture)),
            ],
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: SeatsFeeDetailPayment(isDeparture: widget.isDeparture),
        ),
      ],
    );
  }
}
