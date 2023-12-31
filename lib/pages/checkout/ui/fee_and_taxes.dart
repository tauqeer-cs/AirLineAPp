import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/baggage_fee.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/checkout/ui/fares_and_bundles.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes_detail.dart';
import 'package:app/pages/checkout/ui/meals_fee.dart';
import 'package:app/pages/checkout/ui/seats_fee.dart';
import 'package:app/pages/checkout/ui/wheelchair_fee.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'insurance_fee.dart';

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
    final currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    if (filter?.promoCode != null &&
        discountPercent != null &&
        (discountPercent > 0)) {}

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !isPaymentPage,
          child: Text(
            widget.isDeparture
                ? filter?.beautify ?? ""
                : filter?.beautifyReverse ?? "",
            style: kMediumHeavy,
          ),
        ),
        kVerticalSpacer,
        AppDividerWidget(color: Styles.kDisabledButton),
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                Text(
                  isPaymentPage ? "feesTaxes".tr() : "- ${"feesTaxes".tr()}",
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
                  currency: currency,
                  amount: widget.isDeparture
                      ? bookingTotal.selectedDeparture?.getTotalPriceDisplay
                      : bookingTotal.selectedReturn?.getTotalPriceDisplay,
                ),
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: FeeAndTaxesDetail(
            currency: currency,

            isDeparture: widget.isDeparture,
          ),
        ),
        Visibility(
          visible: (filter?.numberPerson.getTotalBundlesPartial(
                    widget.isDeparture,
                  ) ??
                  0) >
              0,
          child: FaresAndBundles(
            isDeparture: widget.isDeparture,
            currency: currency,

          ),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: SeatsFee(
            isDeparture: widget.isDeparture,
            currency: currency,

          ),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalMealPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: MealsFee(
            currency: currency,
            isDeparture: widget.isDeparture,
          ),
        ),
        Visibility(
          visible: (filter?.numberPerson
                      .getTotalBaggagePartial(widget.isDeparture) ??
                  0) >
              0,
          child: BaggageFee(
            currency: currency,
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
            currency: currency,

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
            currency: currency,
          ),
        ),
        if (widget.isDeparture) ...[
          Visibility(
            visible: (filter?.numberPerson.getTotalInsurance() ?? 0) > 0,
            child:  InsuranceFee(
              currency: currency,
            ),
          ),
        ],
        kVerticalSpacerBig,
      ],
    );
  }
}
