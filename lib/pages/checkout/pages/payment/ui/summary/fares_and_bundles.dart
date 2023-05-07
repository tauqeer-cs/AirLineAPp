import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fares_and_bundles_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FaresAndBundlesPayment extends StatefulWidget {
  final bool isDeparture;
  final String? currency;

  const FaresAndBundlesPayment({Key? key, required this.isDeparture, this.currency}) : super(key: key);

  @override
  State<FaresAndBundlesPayment> createState() => _FaresAndBundlesPaymentState();
}

class _FaresAndBundlesPaymentState extends State<FaresAndBundlesPayment> {
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
               Text(
                "- ${'priceSection.fareBundles'.tr()}",
                style: kMediumRegular,
              ),
              kHorizontalSpacerSmall,
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              const Spacer(),
              MoneyWidgetSmall(
                  currency: widget.currency,
                  amount:filter?.numberPerson.getTotalBundlesPartial(widget.isDeparture)),
            ],
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: FaresAndBundlesDetailPayment(isDeparture: widget.isDeparture),
        ),
      ],
    );
  }
}
