import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingCubit>().state;

    return Visibility(
      visible: booking.isVerify,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        padding: kPageHorizontalPadding,
        color: Color(0xFFededed),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kVerticalSpacer,
            Text(
              "Fares are not guaranteed until payment is made in full and MYAirline confirms your booking. Aircraft subject to change. ",
              style: kLargeMedium.copyWith(height: 2),
            ),
            kVerticalSpacer,
            Text("Flights and bundles summary", style: kGiantSemiBold),
            kVerticalSpacer,
            FeeAndTaxes(isDeparture: true),
            Visibility(
              visible: booking.selectedReturn!=null,
              child: FeeAndTaxes(isDeparture: false),
            ),
          ],
        ),
      ),
    );
  }
}
