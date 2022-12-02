import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/add_on/seats/ui/seats_view.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SeatsPage extends StatelessWidget {
  final bool isDeparture;

  const SeatsPage({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      child: BlocListener<SearchFlightCubit, SearchFlightState>(
        listener: (context, state) {
          if (state.blocState == BlocState.failed) {
            context.router.pop();
          }
        },
        child: Scaffold(
          appBar: AppAppBar(
            title: "Your Trip Starts Here",
            height: 100.h,
            flexibleWidget: AppBookingStep(
              passedSteps: const [BookingStep.flights, BookingStep.addOn],
              onTopStepTaped: (index) {
                if (index == 0) {
                  context.router.popUntilRouteWithName(SearchResultRoute.name);
                } else if (index == 1) {
                  context.router.popUntilRouteWithName(SeatsRoute.name);
                }
              },
            ),
          ),
          body: BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              return blocBuilderWrapper(
                blocState: state.blocState,
                finishedBuilder: SeatsView(isDeparture: isDeparture),
              );
            },
          ),
        ),
      ),
    );
  }
}
