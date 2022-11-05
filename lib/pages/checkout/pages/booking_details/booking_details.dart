import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      child: BlocProvider(
        create: (context) => SummaryCubit(),
        child: BlocListener<SummaryCubit, SummaryState>(
          listener: (context, state) {
            blocListenerWrapper(
              blocState: state.blocState,
              onLoading: () {
                context.loaderOverlay.show(
                  widget: const AppLoadingScreen(message: "Loading"),
                );
              },
              onFailed: () {
                context.loaderOverlay.hide();
                if(state.message.contains("please request a new GUID")){
                  context.router.replaceAll([const NavigationRoute(), const HomeRoute()]);
                }
                Toast.of(context).show(message: state.message);
              },
              onFinished: () {
                context.loaderOverlay.hide();
                context.read<BookingCubit>().summaryFlight(state.summaryRequest);
                context.router.push(const PaymentRoute());
              },
            );
          },
          child: Scaffold(
            appBar: AppAppBar(
              title: "Your Trip Starts Here",
              height: 100.h,
              flexibleWidget: const AppBookingStep(
                passedSteps: [BookingStep.flights, BookingStep.addOn, BookingStep.bookingDetails],
              ),
            ),
            body: const BookingDetailsView(),
          ),
        ),
      ),
    );
  }
}
