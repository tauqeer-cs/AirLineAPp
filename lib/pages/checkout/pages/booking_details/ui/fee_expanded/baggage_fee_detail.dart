import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fee_and_taxes_detail.dart';

class BaggageFeeDetail extends StatelessWidget {
  final bool isDeparture;
  final bool isSports;

  final bool isInsurance;

  const BaggageFeeDetail(
      {Key? key,
      required this.isDeparture,
      this.isSports = false,
      this.isInsurance = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    return Column(
      children: [
        ...persons.map(
          (e) {
            var bundle = isDeparture ? e.departureBaggage : e.returnBaggage;

            if (isSports) {
              bundle = isDeparture ? e.departureSports : e.returnSports;
            } else if (isInsurance) {
              bundle = e.insuranceGroup;
            }
            return bundle?.amount == null
                ? const SizedBox.shrink()
                : PriceContainer(
                    padding: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${e.generateText(filter?.numberPerson)} : ${bundle?.description ?? 'No Bundle'}",
                            style: kSmallRegular.copyWith(
                                color: Styles.kSubTextColor),
                          ),
                        ),
                        kHorizontalSpacerSmall,
                        MoneyWidgetSmall(
                            amount: bundle?.finalAmount,
                            isDense: true,
                            currency: bundle?.currencyCode),
                      ],
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}
