import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/booking_local/booking_local_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/booking_local.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/payment/bloc/payment_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/payment_view.dart';
import 'package:app/pages/checkout/pages/select_baggage/ui/baggage_selections.dart';
import 'package:app/pages/checkout/pages/select_bundle/ui/bundle_list.dart';
import 'package:app/pages/checkout/pages/select_meals/ui/meal_selections.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seat_selections.dart';
import 'package:app/pages/checkout/ui/addon_layout.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: LoaderOverlay(
        child: BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            blocListenerWrapper(
              blocState: state.blocState,
              onLoading: () {
                context.loaderOverlay.show(
                  widget: AppLoadingScreen(message: "Loading"),
                );
              },
              onFailed: () {
                context.loaderOverlay.hide();
                if (state.message == "Error: Reach Maximum Payment Attempts") {
                  context.router.replaceAll([HomeRoute()]);
                }
                Toast.of(context).show(message: state.message);
              },
              onFinished: () async {
                context.loaderOverlay.hide();
                final result = await context.router.push(
                  WebViewRoute(url: "", htmlContent: state.paymentRedirect),
                );
                if (result != null && result is String) {
                  final urlParsed = Uri.parse(result);
                  var query = urlParsed.queryParametersAll;
                  String? status = query['status']?.first;
                  String? superPNR = query['superPNR']?.first;
                  if (status != "FAIL") {
                    if (mounted) {
                      final filter =
                          context.read<SearchFlightCubit>().state.filterState;
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
                    }
                    //context.router.popUntilRoot();
                    context.router.replaceAll([
                      HomeRoute(),
                      BookingConfirmationRoute(bookingId: superPNR ?? "")
                    ]);
                  } else {
                    if (mounted) {
                      Toast.of(context).show(message: "Payment failed");
                    }
                  }
                } else {
                  // context.router.push(HomeRoute());
                  // context.router.replaceAll(
                  //   [
                  //     HomeRoute(),
                  //     BookingConfirmationRoute(bookingId: ""),
                  //   ],
                  // );
                  // context.router.push(HomeRoute());
                  // context.router.push(BookingConfirmationRoute(bookingId: ""));
                }
              },
            );
          },
          child: AppScaffold(
            child: PaymentView(),
          ),
        ),
      ),
    );
  }
}
