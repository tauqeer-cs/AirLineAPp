import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flightType =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    final booking = context.watch<BookingCubit>().state;
    final isAllowedContinue = booking.selectedDeparture != null &&
        (booking.selectedReturn != null || flightType == FlightType.oneWay);
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Your total booking"),
          MoneyWidget(amount: booking.getFinalPrice),
          kVerticalSpacer,
          ElevatedButton(
            onPressed: isAllowedContinue ? () {} : null,
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
