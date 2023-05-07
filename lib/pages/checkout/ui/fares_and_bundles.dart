import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/checkout/ui/fares_and_bundles_detail.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class FaresAndBundles extends StatefulWidget {
  final bool isDeparture;
  final String? currency;

  const FaresAndBundles({Key? key, required this.isDeparture, this.currency})
      : super(key: key);

  @override
  State<FaresAndBundles> createState() => _FaresAndBundlesState();
}

class _FaresAndBundlesState extends State<FaresAndBundles> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final isPaymentPage = context.watch<IsPaymentPageCubit>().state;
    return Column(
      children: [
        InkWell(
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
                  isPaymentPage ? "priceSection.fareBundles".tr() : "- ${'priceSection.fareBundles'.tr()}",
                  style: kMediumRegular,
                ),
                kHorizontalSpacerSmall,
                Icon(
                  isExpand
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                const Spacer(),
                MoneyWidgetSmall(
                    currency: widget.currency,
                    amount: filter?.numberPerson
                        .getTotalBundlesPartial(widget.isDeparture)),
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: FaresAndBundlesDetail(
            isDeparture: widget.isDeparture,
            currency: widget.currency,
          ),
        ),
      ],
    );
  }
}
