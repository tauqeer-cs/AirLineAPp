import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes_detail.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaresAndBundlesDetailPayment extends StatelessWidget {
  final bool isDeparture;

  const FaresAndBundlesDetailPayment({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    return Column(
      children: [
        kVerticalSpacerSmall,
        AppDividerWidget(color: Styles.kDisabledButton),
        ...persons.map(
          (e) {
            final bundle = isDeparture ? e.departureBundle : e.returnBundle;
            return bundle?.bundle?.amount == null
                ? const SizedBox.shrink()
                : PriceContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${e.toString()} : ${bundle?.bundle?.description ?? 'No Bundle'}",
                          style: kSmallRegular.copyWith(
                              color: Styles.kSubTextColor),
                        ),
                        MoneyWidgetSmall(
                            amount: bundle?.bundle?.finalAmount,
                            isDense: true,
                            currency: bundle?.bundle?.currencyCode),
                      ],
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}
