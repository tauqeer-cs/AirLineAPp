import 'package:app/app.dart';
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
import 'package:app/utils/user_insider.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/settings/settings_cubit.dart';
import '../../../../blocs/voucher/voucher_cubit.dart';
import '../../../../theme/theme.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  void isLoggedInPopUp() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await showLoginDialog();
      if (response == true) {
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          detialsKey.currentState?.rebuild();


        });
        //appRouter.pop(true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final isLoggedIn =
        context.read<AuthBloc>().state.status == AppStatus.authenticated;
    if (!isLoggedIn) {
      isLoggedInPopUp();
    }
    FlutterInsider.Instance.itemAddedToCart(
        UserInsider.of(context).generateProduct());
    UserInsider.of(context).registerPurchasedAddOn();
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
          confirmText: "Resend",
          onConfirm: () {
            AuthenticationRepository()
                .sendEmail(ResendEmailRequest(email: email));
          },
          child: Column(
            children: [
              Text(
                "We've sent a verification link to your email ${email.sensorEmail()}. Please check your email and click on the link.",
                style: kMediumHeavy,
              ),
              kVerticalSpacer,
              const Text(
                "Click resend if you didn’t receive the email. ",
              ),
              kVerticalSpacer,
            ],
          ),
        );
      },
    );
    return;
  }

  LoginCubit? loginCubit;

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
      builder: (dialogContext) => LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: SizedBox(
          height: 0.5.sh,
          child: AppLoadingScreen(message: "loading".tr()),
        ),
        child: BlocProvider(
          create: (context) {
            loginCubit = LoginCubit();
            return loginCubit ?? LoginCubit();

          },
          child: MultiBlocListener(
            listeners: [
              BlocListener<LoginCubit, LoginState>(
                listener: (_, state) {
                  blocListenerWrapper(
                    blocState: state.blocState,
                    onLoading: () {
                      context.loaderOverlay.show();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onFailed: () {
                      context.loaderOverlay.hide();
                      Toast.of(context).show(message: state.message);
                    },
                    onFinished: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.loaderOverlay.hide();


                  //    if(loginCubit?.state.message == 'Invalid username/password') {
                    //    return;
                      //}

                      Toast.of(context)
                          .show(message: "welcomeBack".tr(), success: true);

//                      callBack();

                      Navigator.of(dialogContext).pop(true);
                    },
                  );
                },
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (_, state) {
                  if (!(state.user?.isAccountVerified ?? true)) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    showNotVerifiedDialog(
                        context: context, email: state.user?.email ?? "");
                  }
                  if (state.status == AppStatus.authenticated) {
                    // FocusManager.instance.primaryFocus?.unfocus();
                    // context.router.pop();
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
                  formPasswordLoginName: "passwordBooking", fromPopUp: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  GlobalKey<BookingDetailsViewState> detialsKey = GlobalKey<BookingDetailsViewState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: AppLoadingScreen(message: "loading".tr()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => InfoCubit()),
          ],
          child: BlocListener<SummaryCubit, SummaryState>(
            listenWhen: (prev, curr) {
              return prev.blocState != curr.blocState;
            },
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
                  if (state.message.contains("please request a new GUID") ||
                      state.message == "Invalid Token") {
                    context.router.replaceAll(
                        [const NavigationRoute(), const HomeRoute()]);
                  }
                  Toast.of(context).show(message: state.message);
                },
                onFinished: () async {
                  if(context.router.currentPath != BookingDetailsRoute().path) return;
                 print("context.router.currentPath ${context.router.currentPath}");
                  print("BookingDetailsRoute().path ${BookingDetailsRoute().path}");

                  context.loaderOverlay.hide();
                  context
                      .read<BookingCubit>()
                      .summaryFlight(state.summaryRequest);
                  context.router.push(const InsuranceRoute());

                },
              );
            },
            child: Scaffold(
              appBar: AppAppBar(
                title: "almostThere".tr(),
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
              body:  BookingDetailsView(
                key: detialsKey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
