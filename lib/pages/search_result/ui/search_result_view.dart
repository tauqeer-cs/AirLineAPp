import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/home/ui/filter/submit_search.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/flight_result_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVerify = context.watch<BookingCubit>().state.isVerify;
    return ListView(
      children: [
        kVerticalSpacer,
        Visibility(
          visible: !isVerify,
          child: Padding(
            padding: kPageHorizontalPadding,
            child: Column(
              children: [
                SearchFlightWidget(),
                kVerticalSpacer,
                SubmitSearch(isHomePage: false),
                kVerticalSpacerBig,
              ],
            ),
          ),
        ),
        FlightResultWidget(),
        CheckoutSummary(),
        kVerticalSpacer,
        AppDividerWidget(),
        kVerticalSpacer,
        BookingSummary(),
      ],
    );
  }
}
