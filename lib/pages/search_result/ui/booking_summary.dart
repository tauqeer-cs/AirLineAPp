import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterState = context.watch<SearchFlightCubit>().state.filterState;
    final booking = context.watch<BookingCubit>().state;
    final isAllowedContinue = booking.selectedDeparture != null &&
        (booking.selectedReturn != null ||
            filterState?.flightType == FlightType.oneWay);
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Your total booking"),
          MoneyWidget(amount: booking.getFinalPrice),
          kVerticalSpacer,
          ElevatedButton(
            onPressed: isAllowedContinue
                ? () {
                    if (booking.blocState == BlocState.loading) return;
                    if( booking.isVerify){
                      context.router.push(SelectBundleRoute());
                    }else{
                      context.read<BookingCubit>().verifyFlight(filterState);
                    }
                  }
                : null,
            child: booking.blocState == BlocState.loading
                ? AppLoading(color: Colors.white)
                : Text("Continue"),
          ),
        ],
      ),
    );
  }
}
