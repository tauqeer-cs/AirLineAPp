import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/info/info_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/ui/insurance_view.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/settings/settings_cubit.dart';
import '../../../../blocs/voucher/voucher_cubit.dart';

class InsurancePage extends StatefulWidget {
  const InsurancePage({super.key});

  @override
  State<InsurancePage> createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  @override
  void initState() {
    print("reinit insurance page");
    final passengers = context
            .read<SummaryCubit>()
            .state
            .summaryRequest
            ?.flightSummaryPNRRequest
            .passengers ??
        [];
    context.read<InsuranceCubit>().init(passengers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const AppLoadingScreen(message: "Loading"),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => InfoCubit()),
          ],
          child: BlocListener<SummaryCubit, SummaryState>(
            listenWhen: (prev, curr) {
              print("prev blocstate ${prev.blocState}");
              print("curr blocstate ${curr.blocState}");

              return prev.blocState != curr.blocState;
            },
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
                  if (state.message.contains("please request a new GUID") ||
                      state.message == "Invalid Token") {
                    context.router.replaceAll(
                        [const NavigationRoute(), const HomeRoute()]);
                  }
                  Toast.of(context).show(message: state.message);
                },
                onFinished: () async {
                  print("finished here");
                  context.loaderOverlay.hide();
                  context
                      .read<BookingCubit>()
                      .summaryFlight(state.summaryRequest);
                  context.router.push(const PaymentRoute());
                  if (context
                          .read<SettingsCubit>()
                          .state
                          .switchSetting
                          .myReward ??
                      false) {
                    var token = state.summaryResponse?.token ??
                        state.summaryResponse!.token;
                    context.read<VoucherCubit>().state.copyWith(
                        flightToken: state.summaryResponse?.token ??
                            state.summaryResponse!.token);
                    if(user?.token == null){

                    }
                    else if (token != null) {
                      context
                          .read<VoucherCubit>()
                          .getAvailablePromotions(token);
                    }
                    else {

                    }
                  }
                  //VoucherCubit
                },
              );
            },
            child: Scaffold(
              appBar: AppAppBar(
                title: "You Are Almost There",
                height: 100.h,
                flexibleWidget: AppBookingStep(
                  passedSteps: const [
                    BookingStep.flights,
                    BookingStep.addOn,
                    BookingStep.bookingDetails,
                    BookingStep.insurance,
                  ],
                  onTopStepTaped: (int index) {
                    if (index == 0) {
                      context.router
                          .popUntilRouteWithName(SearchResultRoute.name);
                    } else if (index == 1) {
                      context.router.popUntilRouteWithName(SeatsRoute.name);
                    } else if (index == 2) {
                      context.router
                          .popUntilRouteWithName(BookingDetailsRoute.name);
                    }
                  },
                ),
              ),
              body: const InsuranceView(),
            ),
          ),
        ),
      ),
    );
  }
}
