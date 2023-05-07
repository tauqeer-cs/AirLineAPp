import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/number_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaggageSubtotal extends StatelessWidget {
  final Widget child;
  final bool isDeparture;
  const BaggageSubtotal({
    Key? key,
    required this.child,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bool isExpand = context.watch<SummaryContainerCubit>().state;
    final currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';


    return Visibility(
      visible: isExpand,
      child: Container(
        decoration: BoxDecoration(
            color: Styles.kSubTextColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -2),
                blurRadius: 6,
              ),
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "baggageSubtotal".tr(),
                    style: kLargeRegular.copyWith(color: Colors.white),
                  ),
                  Text(
                    "$currency ${NumberUtils.formatNum(filter?.numberPerson.getTotalBaggagePartial(isDeparture))}",
                    style: kLargeHeavy.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            if (filter?.numberPerson.getTotalSportsPartial(isDeparture) !=
                null) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "sportsEquipmentSubtotal".tr(),
                      style: kLargeRegular.copyWith(color: Colors.white),
                    ),
                    Text(
                      "$currency ${NumberUtils.formatNum(filter?.numberPerson.getTotalSportsPartial(isDeparture))}",
                      style: kLargeHeavy.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
