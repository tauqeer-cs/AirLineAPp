import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/baggage_fee_detail.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class BaggageFee extends StatefulWidget {
  final bool isDeparture;

  const BaggageFee({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<BaggageFee> createState() => _BaggageFeeState();
}

class _BaggageFeeState extends State<BaggageFee> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final isPaymentPage = context.watch<IsPaymentPageCubit>().state;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  isPaymentPage ? "Baggage" : "- Baggage",
                  style: kMediumRegular,
                ),
                kHorizontalSpacerSmall,
                Icon(
                  isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
                const Spacer(),
                MoneyWidgetSmall(
                    amount: filter?.numberPerson
                        .getTotalBaggagePartial(widget.isDeparture)),
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: BaggageFeeDetail(isDeparture: widget.isDeparture),
        ),
      ],
    );
  }
}
