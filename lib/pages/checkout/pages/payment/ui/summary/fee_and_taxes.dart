import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/baggage_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fares_and_bundles.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fee_and_taxes_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/insurance_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/meals_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/seats_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/wheelchair_fee.dart';
import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FeeAndTaxesPayment extends StatefulWidget {
  final bool isDeparture;
  final String? currency;

  const FeeAndTaxesPayment({Key? key, required this.isDeparture, this.currency})
      : super(key: key);

  @override
  State<FeeAndTaxesPayment> createState() => _FeeAndTaxesPaymentState();
}

class _FeeAndTaxesPaymentState extends State<FeeAndTaxesPayment> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final insurance = context.watch<InsuranceCubit>().state.totalInsurance();
    print("insurance is $insurance");
    final bookingTotal = context.watch<BookingCubit>().state;


    num? promoAmount = bookingTotal.selectedDeparture?.fareTypeWithTaxDetails?.first.fareInfoWithTaxDetails?.first.promotionAmount;

    String? promoName;

    if(widget.isDeparture == false){

      promoAmount = bookingTotal.selectedReturn?.fareTypeWithTaxDetails?.first.fareInfoWithTaxDetails?.first.promotionAmount;
    }

    if((promoAmount ?? 0.0) > 0){
      promoName = filter?.promoCode;
    }
    return Column(
      children: [
        kVerticalSpacer,
        PriceRow(
          child1:  Text(
            "faresNBundles".tr(),
            style: k18Heavy,
          ),
          child2: MoneyWidgetSummary(
            currency: widget.currency,
            amount: widget.isDeparture
                ? bookingTotal.selectedDeparture?.getTotalPriceDisplay
                : bookingTotal.selectedReturn?.getTotalPriceDisplay,
          ),
        ),
        FeeAndTaxesDetailPayment(isDeparture: widget.isDeparture,currency: widget.currency,promoAmount: promoAmount,promoName: promoName,),
        Visibility(
          visible: (filter?.numberPerson
                      .getTotalBundlesPartial(widget.isDeparture) ??
                  0) >
              0,
          child: FaresAndBundlesPayment(
            currency: widget.currency,
            isDeparture: widget.isDeparture,


          ),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: SeatsFeePayment(
              currency: widget.currency,

              isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalMealPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: MealsFeePayment(
              currency: widget.currency,
              isDeparture: widget.isDeparture),
        ),
        if (widget.isDeparture) ...[
          Visibility(
            visible: insurance > 0,
            child:  InsuarnceFeePayment(
              currency: widget.currency,

              isDeparture: true,),
          ),
        ],
        Visibility(
          visible: (filter?.numberPerson
                      .getTotalBaggagePartial(widget.isDeparture) ??
                  0) >
              0,
          child: BaggageFeePayment(
              currency: widget.currency,

              isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible: (filter?.numberPerson
                      .getTotalWheelChairPartial(widget.isDeparture) ??
                  0) >
              0,
          child: WheelchairFeePayment(
              currency: widget.currency,
              isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalSportsPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: BaggageFeePayment(
            currency: widget.currency,
            isDeparture: widget.isDeparture,
            isSports: true,
          ),
        ),
        // Visibility(
        //   visible: insurance > 0,
        //   child: InsuranceFee(),
        // ),
        kVerticalSpacerBig,
      ],
    );
  }
}
