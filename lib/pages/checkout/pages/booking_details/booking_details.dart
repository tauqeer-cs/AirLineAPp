import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/requests/resend_email_request.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/pages/auth/ui/login_form.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/info/info_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../../add_on/seats/seats_page.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  @override
  void initState() {
    super.initState();
    final isLoggedIn =
        context.read<AuthBloc>().state.status == AppStatus.authenticated;
    if (!isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showLoginDialog());
    }
    temporarySummaryRequest();
  }

  temporarySummaryRequest() {
    final bookingState = context.read<BookingCubit>().state;
    final state = context.read<SearchFlightCubit>().state;
    final verifyToken = bookingState.verifyResponse?.token;
    final flightSeats = bookingState.verifyResponse?.flightSeat;
    final flightInfant = bookingState.verifyResponse?.flightSSR?.infantGroup;
    final outboundSeats = flightSeats?.outbound;
    final inboundSeats = flightSeats?.inbound;

    final rowsOutBound = outboundSeats
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    final rowsInBound = inboundSeats
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    final persons = state.filterState?.numberPerson;
    List<Passenger> passengers = [];
    for (Person person in (persons?.persons ?? [])) {
      final passenger = person.toPassenger(
        outboundRows: rowsOutBound ?? [],
        inboundRows: rowsInBound ?? [],
        numberPerson: persons,
        infantGroup: flightInfant,
        inboundPhysicalId: inboundSeats
            ?.firstOrNull
            ?.retrieveFlightSeatMapResponse
            ?.physicalFlights
            ?.firstOrNull
            ?.physicalFlightID,
        outboundPhysicalId: outboundSeats
            ?.firstOrNull
            ?.retrieveFlightSeatMapResponse
            ?.physicalFlights
            ?.firstOrNull
            ?.physicalFlightID,
      );
      passengers.add(passenger);

      final summaryRequest = SummaryRequest(
        token: verifyToken ?? "",
        flightSummaryPNRRequest: FlightSummaryPnrRequest(
          passengers: passengers,
        ),
      );
      context.read<BookingCubit>().summaryFlight(summaryRequest);
    }
  }

  showNotVerifiedDialog({
    required BuildContext context,
    required String email,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AppConfirmationDialog(
          title: "Your email hasn't been verified yet.",
          subtitle:
              "Hey, you haven't verified your MYReward account yet! Earn points and get amazing deals for your flight experience with MYAirline.",
          child: Column(
            children: [
              Text(
                "We've sent a verification link to your email ${email.sensorEmail()}. Please check your email and click on the link.",
                style: kMediumHeavy,
              ),
              kVerticalSpacer,
              Text(
                "Click resend if you didn’t receive the email. ",
              ),
              kVerticalSpacer,
            ],
          ),
          confirmText: "Resend",
          onConfirm: () {
            AuthenticationRepository()
                .sendEmail(ResendEmailRequest(email: email));
          },
        );
      },
    );
    return;
  }

  showLoginDialog() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
      constraints: BoxConstraints(
        maxWidth: 0.9.sw,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (_) => LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: SizedBox(
          height: 0.5.sh,
          child: const AppLoadingScreen(message: "Loading"),
        ),
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  blocListenerWrapper(
                    blocState: state.blocState,
                    onLoading: () => context.loaderOverlay.show(),
                    onFailed: () {
                      context.loaderOverlay.hide();
                      Toast.of(context).show(message: state.message);
                    },
                    onFinished: () => context.loaderOverlay.hide(),
                  );
                },
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (_, state) {
                  print("auth listener ${state.user?.isAccountVerified}");
                  if (!(state.user?.isAccountVerified ?? true)) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    showNotVerifiedDialog(
                        context: context, email: state.user?.email ?? "");
                  }
                  if (state.status == AppStatus.authenticated) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.router.pop();
                  }
                },
              ),
            ],
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  12, 12, 12, MediaQuery.of(context).viewInsets.bottom + 20),
              child: SingleChildScrollView(
                child: LoginForm(
                  fbKey: JosKeys.gKeysBooking,
                  showContinueButton: true,
                  formEmailLoginName: "emailBooking",
                  formPasswordLoginName: "passwordBooking",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: LoaderOverlay(
        useDefaultLoading: false,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SummaryCubit()),
            BlocProvider(create: (context) => InfoCubit()),
          ],
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
                  if (state.message.contains("please request a new GUID") ||
                      state.message == "Invalid Token") {
                    context.router.replaceAll(
                        [const NavigationRoute(), const HomeRoute()]);
                  }
                  Toast.of(context).show(message: state.message);
                },
                onFinished: () {
                  print("go to summary route");
                  context.loaderOverlay.hide();
                  context
                      .read<BookingCubit>()
                      .summaryFlight(state.summaryRequest);
                  context.router.push(const PaymentRoute());
                },
              );
            },
            child: Scaffold(
              appBar: AppAppBar(
                title: "Your Trip Starts Here",
                height: 100.h,
                flexibleWidget: AppBookingStep(
                  passedSteps: const [
                    BookingStep.flights,
                    BookingStep.addOn,
                    BookingStep.bookingDetails
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
              body: const BookingDetailsView(),
            ),
          ),
        ),
      ),
    );
  }
}
