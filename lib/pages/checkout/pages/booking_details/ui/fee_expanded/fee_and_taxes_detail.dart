import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/constant_utils.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FeeAndTaxesDetail extends StatelessWidget {
  final bool isDeparture;
  final double? padding;

  const FeeAndTaxesDetail({Key? key, required this.isDeparture, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.watch<BookingCubit>().state;
    final segment = isDeparture
        ? bookingCubit.selectedDeparture
        : bookingCubit.selectedReturn;
    final info = segment?.fareTypeWithTaxDetails?.firstOrNull
        ?.fareInfoWithTaxDetails?.firstOrNull;
    final List<ApplicationTaxDetailBinds>? taxes =
        info?.applicationTaxDetailBinds;
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final verifyResponse = bookingCubit.verifyResponse;
    final infantInbound =
        verifyResponse?.flightSSR?.infantGroup?.inbound?.firstOrNull;
    final infantOutbound =
        verifyResponse?.flightSSR?.infantGroup?.outbound?.firstOrNull;
    final infant = isDeparture ? infantOutbound : infantInbound;
    if (taxes?.isEmpty ?? true) return const SizedBox();
    num discountTotal = 0;

    if (ConstantUtils.showPromoInFeesAndTaxes) {
      var discountPercent = bookingCubit.selectedDeparture!.discountPCT;

      if (filter?.promoCode != null &&
          discountPercent != null &&
          (discountPercent > 0)) {
        discountTotal = 1;
        var a =
            bookingCubit.selectedDeparture!.beforeDiscountTotalAmtWithInfantSSR;
        var b =
            bookingCubit.selectedDeparture!.totalSegmentFareAmtWithInfantSSR;

        discountTotal = a! - b!;
      }
    }

    return Column(
      children: [
        PriceContainer(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ticket".tr(),
                style: kSmallRegular.copyWith(color: Styles.kTextColor),
              ),
              Align(
                  child: MoneyWidgetSmall(
                      amount: info?.baseFareAmt, isDense: true)),
            ],
          ),
        ),
        ...taxes!
            .map(
              (e) => PriceContainer(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        e.taxDetail?.taxDesc ?? "",
                        style:
                            kSmallRegular.copyWith(color: Styles.kTextColor),
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
        Visibility(
          visible: (filter?.numberPerson.numberOfInfant ?? 0) > 0,
          child: PriceContainer(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Infant",
                  style: kSmallRegular.copyWith(color: Styles.kSubTextColor),
                ),
                Row(
                  children: [
                    Text(
                      "${filter?.numberPerson.numberOfInfant ?? 0}x @",
                      style:
                          kSmallRegular.copyWith(color: Styles.kSubTextColor),
                    ),
                    kHorizontalSpacerMini,
                    MoneyWidgetSmall(
                        amount:
                            infant?.finalAmount ?? segment?.infantPricePerPax,
                        isDense: true),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (discountTotal > 0 && ConstantUtils.showPromoInFeesAndTaxes) ...[
          Visibility(
            visible: (filter?.numberPerson.numberOfInfant ?? 0) > 0,
            child: PriceContainer(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Promo\n${filter?.promoCode ?? ''}",
                    style: kSmallRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                  MoneyWidgetSmall(
                    amount: discountTotal,
                    isDense: true,
                    isNegative: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class PriceContainer extends StatelessWidget {
  final Widget child;
  final double? padding;

  const PriceContainer({Key? key, required this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: padding ?? 15),
      child: child,
    );
  }
}
