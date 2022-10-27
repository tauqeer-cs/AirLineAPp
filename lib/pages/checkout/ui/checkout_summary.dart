import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutSummary extends StatefulWidget {
  const CheckoutSummary({Key? key}) : super(key: key);

  @override
  State<CheckoutSummary> createState() => _CheckoutSummaryState();
}

class _CheckoutSummaryState extends State<CheckoutSummary> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingCubit>().state;

    return Visibility(
      visible: booking.isVerify,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kVerticalSpacer,
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpand = !isExpand;
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: kPageHorizontalPadding,
                    child: Text("Flights and bundles summary", style: k18Heavy),
                  ),
                  Spacer(),
                  Icon(
                    isExpand
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
            kVerticalSpacer,
            ExpandedSection(
              expand: isExpand,
              child: Container(
                padding: kPageHorizontalPadding,
                color: Styles.kDividerColor,
                child: Column(
                  children: [
                    kVerticalSpacer,
                    FeeAndTaxes(isDeparture: true),
                    Visibility(
                      visible: booking.selectedReturn != null,
                      child: FeeAndTaxes(isDeparture: false),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: kPageHorizontalPadding,
              child: Text(
                "Fares are not guaranteed until payment is made in full and MYAirline confirms your booking.\n\nAircraft subject to change. ",
                style: kMediumRegular.copyWith(
                  color: Styles.kSubTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
