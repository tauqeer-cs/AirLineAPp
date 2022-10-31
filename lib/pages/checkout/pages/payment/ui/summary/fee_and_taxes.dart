import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/baggage_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fares_and_bundles.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fee_and_taxes_detail.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/meals_fee.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/seats_fee.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeeAndTaxesPayment extends StatefulWidget {
  final bool isDeparture;

  const FeeAndTaxesPayment({Key? key, required this.isDeparture}) : super(key: key);

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
        Text(
          widget.isDeparture
              ? filter?.beautify ?? ""
              : filter?.beautifyReverse ?? "",
          style: kMediumHeavy,
        ),
        kVerticalSpacer,
        AppDividerWidget(color: Styles.kDisabledButton),
        ListTile(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          title: Row(
            children: [
              Text(
                "- Fees and Taxes",
                style: kMediumRegular,
              ),
              kHorizontalSpacerSmall,
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              Spacer(),
              MoneyWidgetSmall(
                  amount: widget.isDeparture
                      ? bookingTotal.selectedDeparture?.getTotalPrice
                      : bookingTotal.selectedReturn?.getTotalPrice),
            ],
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: FeeAndTaxesDetailPayment(isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible: (filter?.numberPerson
                      .getTotalBundlesPartial(widget.isDeparture) ??
                  0) >
              0,
          child: FaresAndBundlesPayment(isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible: (filter?.numberPerson
              .getTotalSeatsPartial(widget.isDeparture) ??
              0) >
              0,
          child: SeatsFeePayment(isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible: (filter?.numberPerson
              .getTotalMealPartial(widget.isDeparture) ??
              0) >
              0,
          child: MealsFeePayment(isDeparture: widget.isDeparture),
        ),
        Visibility(
          visible: (filter?.numberPerson
              .getTotalBaggagePartial(widget.isDeparture) ??
              0) >
              0,
          child: BaggageFeePayment(isDeparture: widget.isDeparture),
        ),
        kVerticalSpacerBig,
      ],
    );
  }
}
