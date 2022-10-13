import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
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

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
                Toast.of(context).show(message: state.message);
              },
              onFinished: () {
                context.loaderOverlay.hide();
                //context.read<BookingCubit>().summaryFlight(state.summaryRequest);
                context.router.push(
                  WebViewRoute(url: "", htmlContent: state.paymentRedirect),
                );
              },
            );
          },
          child: Scaffold(
            appBar: AppAppBar(),
            body: PaymentView(),
          ),
        ),
      ),
    );
  }
}
