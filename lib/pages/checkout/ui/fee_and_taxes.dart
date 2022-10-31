import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/baggage_fee.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/checkout/ui/fares_and_bundles.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes_detail.dart';
import 'package:app/pages/checkout/ui/meals_fee.dart';
import 'package:app/pages/checkout/ui/seats_fee.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeeAndTaxes extends StatefulWidget {
  final bool isDeparture;

  const FeeAndTaxes(
      {Key? key, required this.isDeparture})
      : super(key: key);

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
    return Column(
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
        Visibility(
          visible: is,
          child: ListTile(
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
        ),
        ExpandedSection(
          expand: isExpand,
          child: FeeAndTaxesDetail(
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
        kVerticalSpacerBig,
      ],
    );
  }
}
