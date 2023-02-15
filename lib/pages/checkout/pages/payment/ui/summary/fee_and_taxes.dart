import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/localizations/localizations_util.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/baggage_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fares_and_bundles.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fee_and_taxes_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/meals_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/seats_fee.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/insurance_fee.dart';

class FeeAndTaxesPayment extends StatefulWidget {
  final bool isDeparture;

  const FeeAndTaxesPayment({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  State<FeeAndTaxesPayment> createState() => _FeeAndTaxesPaymentState();
}

class _FeeAndTaxesPaymentState extends State<FeeAndTaxesPayment> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    return Column(
      children: [
        kVerticalSpacer,
        PriceRow(
          child1: const Text(
            "Fares And Bundles",
            style: k18Heavy,
          ),
          child2: MoneyWidgetSummary(
            amount: widget.isDeparture
                ? bookingTotal.selectedDeparture?.getTotalPriceDisplay
                : bookingTotal.selectedReturn?.getTotalPriceDisplay,
          ),
        ),
        FeeAndTaxesDetailPayment(isDeparture: widget.isDeparture),

        Visibility(
          visible: (filter?.numberPerson
                      .getTotalBundlesPartial(widget.isDeparture) ??
                  0) >
              0,
          child: FaresAndBundlesPayment(isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: SeatsFeePayment(isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible:
              (filter?.numberPerson.getTotalMealPartial(widget.isDeparture) ??
                      0) >
                  0,
          child: MealsFeePayment(isDeparture: widget.isDeparture),
        ),

        if(widget.isDeparture) ... [


          Visibility(
            visible: (filter?.numberPerson
                .getTotalInsurance() ??
                0) >
                0,
            child: const InsuranceFeeSummary(),
          ),


        ],


        Visibility(
          visible: (filter?.numberPerson
                      .getTotalBaggagePartial(widget.isDeparture) ??
                  0) >
              0,
          child: BaggageFeePayment(isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible: (filter?.numberPerson
              .getTotalSportsPartial(widget.isDeparture) ??
              0) >
              0,
          child: BaggageFeePayment(isDeparture: widget.isDeparture,isSports: true,),
        ),

        kVerticalSpacerBig,
      ],
    );
  }
}
