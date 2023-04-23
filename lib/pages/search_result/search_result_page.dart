import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/resend_email_request.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/pages/auth/ui/login_form.dart';
import 'package:app/pages/search_result/ui/search_result_view.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../theme/theme.dart';

class SearchResultPage extends StatefulWidget {
  final bool showLoginDialog;

  const SearchResultPage({Key? key, required this.showLoginDialog})
      : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  void initState() {
    final isLoggedIn =
        context.read<AuthBloc>().state.status == AppStatus.authenticated;

    UserInsider.of(context).registerEventWithParameterProduct(
        InsiderConstants.searchFlightResultPage);
    if (!isLoggedIn && widget.showLoginDialog && false) {
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
          create: (context) => LoginCubit(),
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
                      Navigator.of(dialogContext).pop();
                      Toast.of(context)
                          .show(message: "Welcome back", success: true);
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
                    /*print("auth logged in");
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.router.pop();*/
                  }
                },
              ),
            ],
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                16,
                20,
                MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: LoginForm(
                  fbKey: JosKeys.gKeysSearch,
                  showContinueButton: true,
                  formEmailLoginName: "emailSearch",
                  formPasswordLoginName: "passwordSearch",
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
      overlayWidget: AppLoadingScreen(message: "loading".tr()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SearchFlightCubit, SearchFlightState>(
            listener: (context, state) {
              // if (state.blocState == BlocState.failed) {
              //   context.router.pop();
              // }
            },
          ),
          // BlocListener<BookingCubit, BookingState>(
          //   listener: (context, state) {
          //     blocListenerWrapper(
          //       blocState: state.blocState,
          //       onLoading: () => context.loaderOverlay.show(),
          //       onFailed: () {
          //         context.loaderOverlay.hide();
          //         Toast.of(context).show(message: state.message);
          //       },
          //       onFinished: () {
          //         context.loaderOverlay.hide();
          //         context.read<SummaryContainerCubit>().changeVisibility(true);
          //         context.router.push(SeatsRoute());
          //       },
          //     );
          //   },
          // ),
        ],
        child: Scaffold(
          appBar: AppAppBar(
            title: "yourTripStartsHere".tr(),
            height: 100.h,
            flexibleWidget: AppBookingStep(
              passedSteps: const [BookingStep.flights],
              onTopStepTaped: (int index) {},
            ),
          ),
          body: SearchResultView(),
        ),
      ),
    );
  }
}
