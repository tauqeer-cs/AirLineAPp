import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_router.dart';

class ChangeSearchPage extends StatelessWidget {
  const ChangeSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PriceRangeCubit(),
      child: Scaffold(
        appBar: AppAppBar(
          title: "Your Trip Starts Here",
          height: 100.h,
          flexibleWidget: AppBookingStep(
            passedSteps: [BookingStep.flights],
            onTopStepTaped: (int index) {
              if (index == 0) {
                context.router.popUntilRouteWithName(SearchResultRoute.name);
              }
            },
          ),
        ),
        body: Padding(
          padding: kPagePadding,
          child: SearchFlightWidget(
            isHome: false,
          ),
        ),
      ),
    );
  }
}
