import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/checkout/ui/fares_and_bundles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'baggage_fee.dart';
import 'fee_and_taxes_detail.dart';
import 'insurance_fee.dart';
import 'meals_fee.dart';
import 'seats_fee.dart';
import 'wheelchair_fee.dart';

class FeeAndTaxes extends StatefulWidget {
  final bool isDeparture;

  const FeeAndTaxes({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<FeeAndTaxes> createState() => _FeeAndTaxesState();
}

class _FeeAndTaxesState extends State<FeeAndTaxes> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    final isPaymentPage = context.watch<IsPaymentPageCubit>().state;

    final booking = context.watch<BookingCubit>().state;
    var discountPercent = booking.selectedDeparture?.discountPCT;

    var discountTotal = 0;
    var currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    if (filter?.promoCode != null &&
        discountPercent != null &&
        (discountPercent > 0)) {}

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        InkWell(
          onTap: () {
            setState(() {
              true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            child: Row(
              children: [
                Text(
                  isPaymentPage ? "feesTaxes".tr() : "- ${"feesTaxes".tr()}",
                  style: kMediumHeavy,
                ),
                kHorizontalSpacerSmall,
                const Spacer(),
                MoneyWidgetCustom(
                  currency: currency,
                  fontWeight: FontWeight.w700,
                  amount: widget.isDeparture
                      ? bookingTotal.selectedDeparture?.getTotalPriceDisplay
                      : bookingTotal.selectedReturn?.getTotalPriceDisplay,
                ),
              ],
            ),
          ),
        ),
        FeeAndTaxesDetailDetailed(
          isDeparture: widget.isDeparture,
          padding: 0,
        ),
        Visibility(
          visible: (filter?.numberPerson.getTotalBundlesPartial(
                    widget.isDeparture,
                  ) ??
                  0) >
              0,
          child: FaresAndBundles(
            isDeparture: widget.isDeparture,
          ),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: SeatsFee(

            isDeparture: widget.isDeparture,
          ),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalMealPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: MealsFee(
            isDeparture: widget.isDeparture,
          ),
        ),
        Visibility(
          visible: (filter?.numberPerson
                      .getTotalBaggagePartial(widget.isDeparture) ??
                  0) >
              0,
          child: BaggageFee(
            isDeparture: widget.isDeparture,
          ),
        ),
        Visibility(
          visible: (filter?.numberPerson
              .getTotalWheelChairPartial(widget.isDeparture) ??
              0) >
              0,
          child: WheelChairFee(
            isDeparture: widget.isDeparture,
          ),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalSportsPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: BaggageFee(
            isDeparture: widget.isDeparture,
            isSports: true,
          ),
        ),
        if (widget.isDeparture) ...[
          Visibility(
            visible: (filter?.numberPerson.getTotalInsurance() ?? 0) > 0,
            child: const InsuranceFee(),
          ),
        ],
        kVerticalSpacerBig,
      ],
    );
  }
}
