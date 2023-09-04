import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/constant_utils.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FeeAndTaxesDetailDetailed extends StatelessWidget {
  final bool isDeparture;
  final double? padding;
  final bool hideTicket;
  final String? promoName;
  final num? promoAmount;


  const FeeAndTaxesDetailDetailed({Key? key, required this.isDeparture, this.padding,  this.hideTicket = false, this.promoName, this.promoAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.watch<BookingCubit>().state;
    final segment = isDeparture
        ? bookingCubit.selectedDeparture
        : bookingCubit.selectedReturn;

    List<ApplicableTaxDetails> allTaxes = bookingCubit.verifyResponse?.flightVerifyResponseV2?.result?.flightSegments?.first.fareTypes?.first.fareInfos?.first.applicableTaxDetails ?? [];

    if(isDeparture == false) {

      allTaxes = bookingCubit.verifyResponse?.flightVerifyResponseV2?.result?.flightSegments?.last.fareTypes?.first.fareInfos?.first.applicableTaxDetails ?? [];

    }
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
    if (allTaxes?.isEmpty ?? true) return const SizedBox();
    num discountTotal = 0;

    var currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

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
        if(hideTicket == true) ... [

        ] else ... [
          PriceContainer(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ticket".tr(),
                  style: kSmallRegular.copyWith(color: Styles.kTextColor),
                ),
                if((filter?.numberPerson.totalPerson ?? 0) > 1) ... [
                  Spacer(),
                  Text(
                    "${filter?.numberPerson.totalPerson}x @",
                    style: kSmallRegular.copyWith(
                        color: Styles.kSubTextColor),
                  ),
                  const SizedBox(width: 4,),
                ],


                Align(
                    child: MoneyWidgetSmall(
                        currency : currency,
                        amount: info?.baseFareAmt, isDense: true)),
              ],
            ),
          ),

          Visibility(
            visible: (filter?.numberPerson.numberOfInfant ?? 0) > 0,
            child: PriceContainer(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'infant'.tr(),
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
                          currency: currency,
                          amount:
                          infant?.finalAmount ?? segment?.infantPricePerPax,
                          isDense: true),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],

        for(ApplicableTaxDetails currentTax in  allTaxes) ... [

          PriceContainer(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    currentTax.taxDesc ?? "",
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
                    MoneyWidgetSmall(amount: currentTax.amt, isDense: true,currency: currency,),
                  ],
                ),
              ],
            ),
          ),
        ],


        if(promoName != null) ... [
          PriceContainer(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    this.promoName ?? '',
                    style:
                    kSmallRegular.copyWith(color: Styles.kTextColor),
                  ),
                ),
                kHorizontalSpacerMini,
                MoneyWidgetSmall(amount: promoAmount ?? 0.0, isDense: true,currency: currency,isNegative: true,),

              ],
            ),
          ),
        ],
        if (discountTotal > 0 && ConstantUtils.showPromoInFeesAndTaxes) ...[
          Visibility(
            visible: (filter?.numberPerson.numberOfInfant ?? 0) > 0,
            child: PriceContainer(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${'promo'.tr()}\n${filter?.promoCode ?? ''}",
                    style: kSmallRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                  MoneyWidgetSmall(
                    amount: discountTotal,
                    currency: currency,

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
