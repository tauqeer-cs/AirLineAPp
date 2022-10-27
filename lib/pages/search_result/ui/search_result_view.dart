import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/home/ui/filter/submit_search.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/flight_result_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        kVerticalSpacer,
        FlightResultWidget(),
        CheckoutSummary(),
        kVerticalSpacer,
        SummaryContainer(
          child: Padding(
            padding: kPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BookingSummary(),
                ContinueButton(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingCubit>().state;
    final filterState = context.watch<SearchFlightCubit>().state.filterState;
    final isAllowedContinue = booking.selectedDeparture != null &&
        (booking.selectedReturn != null ||
            filterState?.flightType == FlightType.oneWay);

    return ElevatedButton(
      onPressed: isAllowedContinue
          ? () {
        if (booking.blocState == BlocState.loading) return;
        if (booking.isVerify) {
          context.router.push(SelectBundleRoute());
        } else {
          context.read<BookingCubit>().verifyFlight(filterState);
        }
      }
          : null,
      child: booking.blocState == BlocState.loading
          ? AppLoading(color: Colors.white)
          : Text("Continue"),
    );
  }
}
