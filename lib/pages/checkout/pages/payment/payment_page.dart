import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/booking_local/booking_local_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/timer/timer_bloc.dart';
import 'package:app/models/booking_local.dart';
import 'package:app/pages/checkout/pages/payment/bloc/payment_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/payment_view.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/voucher/voucher_cubit.dart';
import '../../../check_in/bloc/check_in_cubit.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  void initState() {
    super.initState();
    FlutterInsider.Instance.visitCartPage(
        [UserInsider.of(context).generateProduct()]);

    context.read<VoucherCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final superPnr = context.read<BookingCubit>().state.superPnrNo;
        if (superPnr != null) {
          showDialog(
            context: context,
            builder: (context) {
              return AppConfirmationDialog(
                showCloseButton: true,
                title:
                    "You cannot edit after making a failed payment; if you want to edit, you need to restart the booking process.",
                subtitle: "",
                onConfirm: () {
                  context.router.replaceAll([const NavigationRoute()]);
                  context.read<TimerBloc>().add(const TimerReset());
                },
                confirmText: "Restart",
                cancelText: "Stay",
                onCancel: () => context.router.pop(),
              );
            },
          );
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PaymentCubit(),
            ),
          ],
          child: LoaderOverlay(
            child: MultiBlocListener(
              listeners: [
                BlocListener<PaymentCubit, PaymentState>(
                  listener: (context, state) {
                    blocListenerWrapper(
                      blocState: state.blocState,
                      onLoading: () {
                        context.loaderOverlay.show(
                          widget: AppLoadingScreen(message: "loading".tr()),
                        );
                      },
                      onFailed: () {
                        context.loaderOverlay.hide();
                        if (state.message == "Reach Maximum Payment Attempts") {
                          context.router.replaceAll([const NavigationRoute()]);
                        }
                        Toast.of(context).show(message: state.message);
                      },
                      onFinished: () async {
                        context.loaderOverlay.hide();
                        context.read<BookingCubit>().updateSuperPnrNo(
                            state.paymentResponse?.superPnrNo);
                        context.read<TimerBloc>().add(
                              TimerStarted(
                                duration: 900,
                                expiredTime: DateTime.now().toUtc().add(
                                      const Duration(seconds: 900),
                                    ),
                              ),
                            );
                        FlutterInsider.Instance.visitCartPage(
                            [UserInsider.of(context).generateProduct()]);

                        final result = await context.router.push(
                          WebViewRoute(
                              url: "", htmlContent: state.paymentRedirect),
                        );
                        if (result != null && result is String) {
                          final urlParsed = Uri.parse(result);
                          var query = urlParsed.queryParametersAll;
                          String? status = query['status']?.first;
                          String? superPNR = query['superPNR']?.first;
                          if (status == 'VISAFAIL') {
                            if (mounted) {
                              Toast.of(context).show(
                                  message:
                                      'Oops sorry, this promo is not applicable for your card type.');
                            }
                          } else if (status != "FAIL") {
                            if (mounted) {
                              final filter = context
                                  .read<SearchFlightCubit>()
                                  .state
                                  .filterState;
                              final bookingLocal = BookingLocal(
                                bookingId: superPNR,
                                departureDate: filter?.departDate,
                                returnDate: filter?.returnDate,
                                departureString: filter?.beautify,
                                returnString: filter?.beautifyReverse,
                              );
                              context
                                  .read<BookingLocalCubit>()
                                  .saveBooking(bookingLocal);
                              FlutterInsider.Instance.itemPurchased(
                                superPNR.setNoneIfNullOrEmpty,
                                UserInsider.of(context).generateProduct(),
                              );
                            }


                            context.router.replaceAll([
                              const NavigationRoute(),
                              BookingConfirmationRoute(
                                  bookingId: superPNR ?? "",)
                            ]);
                          } else {
                            if (mounted) {
                              Toast.of(context).show(message: "Payment failed");
                            }
                          }
                        } else {}
                      },
                    );
                  },
                ),
                BlocListener<BookingCubit, BookingState>(
                  listener: (context, state) {
                    blocListenerWrapper(
                      blocState: state.blocState,
                      onLoading: () {
                        context.loaderOverlay.show(
                          widget: AppLoadingScreen(message: "loading".tr()),
                        );
                      },
                      onFailed: () {
                        context.loaderOverlay.hide();
                        if (state.message == "Booking Expired") {
                          context.router.replaceAll([const NavigationRoute()]);
                        }
                        Toast.of(context).show(message: state.message);
                      },
                      onFinished: () async {
                        context.loaderOverlay.hide();
                        context
                            .read<PaymentCubit>()
                            .updateSuperPnr(state.superPnrNo ?? "");
                      },
                    );
                  },
                ),
              ],
              child: Scaffold(
                appBar: AppAppBar(
                  title: "yourTripStartsHere".tr(),
                  height: 100.h,
                  flexibleWidget: AppBookingStep(
                    passedSteps: const [
                      BookingStep.flights,
                      BookingStep.addOn,
                      BookingStep.bookingDetails,
                      BookingStep.insurance,
                      BookingStep.payment
                    ],
                    onTopStepTaped: (int index) {
                      final superPnr =
                          context.read<BookingCubit>().state.superPnrNo;
                      if (superPnr != null) return;
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
                body: BlocBuilder<VoucherCubit, VoucherState>(
                    builder: (context, state) {
                  return PaymentView(
                    promoReady: state.promoLoaded,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
