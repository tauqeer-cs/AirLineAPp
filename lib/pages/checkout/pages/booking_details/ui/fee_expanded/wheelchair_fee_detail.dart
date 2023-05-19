import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fee_and_taxes_detail.dart';

class WheelChairFeeDetail extends StatelessWidget {
  final bool isDeparture;

  const WheelChairFeeDetail({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    var currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    return Column(
      children: [
        ...persons.map(
          (e) {
            var bundle =
                isDeparture ? e.departureWheelChair : e.returnWheelChair;
            return bundle?.amount == null
                ? const SizedBox.shrink()
                : PriceContainer(
                    padding: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${e.generateText(filter?.numberPerson)} : ${bundle?.description ?? 'noBundle'.tr()}",
                            style: kSmallRegular.copyWith(
                                color: Styles.kSubTextColor),
                          ),
                        ),
                        kHorizontalSpacerSmall,
                        MoneyWidgetSmall(
                            currency : currency,
                            amount: bundle?.finalAmount,
                            isDense: true,),
                      ],
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}
