import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/resend_email_request.dart';
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
    final isLoggedIn =
        context.read<AuthBloc>().state.status == AppStatus.authenticated;

    if (!isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showLoginDialog());
    }
    super.initState();
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
                  showContinueButton: true,
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
    return LoaderOverlay(
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
                if (state.message.contains("please request a new GUID")) {
                  context.router
                      .replaceAll([const NavigationRoute(), const HomeRoute()]);
                }
                Toast.of(context).show(message: state.message);
              },
              onFinished: () {
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
              flexibleWidget:  AppBookingStep(
                passedSteps: [
                  BookingStep.flights,
                  BookingStep.addOn,
                  BookingStep.bookingDetails
                ], onTopStepTaped: (int index) {
                if(index == 0) {
                  context.router.popTop(SearchResultRoute(showLoginDialog: false));
                }
                else if(index == 1) {
                  context.router.popTop(SeatsRoute());
                }
              },
              ),
            ),
            body: const BookingDetailsView(),
          ),
        ),
      ),
    );
  }
}
