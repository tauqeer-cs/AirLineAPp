import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class FeeAndTaxesDetail extends StatelessWidget {
  final bool isDeparture;

  const FeeAndTaxesDetail({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final segment = isDeparture
        ? context.watch<BookingCubit>().state.selectedDeparture
        : context.watch<BookingCubit>().state.selectedReturn;
    final info = segment?.fareTypeWithTaxDetails?.firstOrNull
        ?.fareInfoWithTaxDetails?.firstOrNull;
    final List<ApplicationTaxDetailBinds>? taxes =
        info?.applicationTaxDetailBinds;
    final filter = context.watch<SearchFlightCubit>().state.filterState;

    if (taxes?.isEmpty ?? true) return SizedBox();
    return Column(
      children: [
        AppDividerWidget(color: Styles.kDisabledButton),
        PriceContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ticket",
                style: kSmallRegular.copyWith(color: Styles.kSubTextColor),
              ),
              Row(
                children: [
                  Text(
                    "${filter?.numberPerson.totalPerson}x @",
                    style: kSmallRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                  kHorizontalSpacerMini,
                  MoneyWidgetSmall(amount: info?.baseFareAmt, isDense: true),
                ],
              ),
            ],
          ),
        ),
        ...taxes!
            .map(
              (e) => PriceContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        e.taxDetail?.taxDesc ?? "",
                        style:
                            kSmallRegular.copyWith(color: Styles.kSubTextColor),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${filter?.numberPerson.totalPerson}x @",
                          style: kSmallRegular.copyWith(
                              color: Styles.kSubTextColor),
                        ),
                        kHorizontalSpacerMini,
                        MoneyWidgetSmall(amount: e.amt, isDense: true),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        AppDividerWidget(color: Styles.kDisabledButton),
      ],
    );
  }
}

class PriceContainer extends StatelessWidget {
  final Widget child;
  const PriceContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: child,
    );
  }
}

