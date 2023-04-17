import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/resend_email_request.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/pages/auth/ui/login_form.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../blocs/settings/settings_cubit.dart';
import '../../../../../blocs/voucher/voucher_cubit.dart';
import '../../../../../data/responses/promotions_response.dart';
import '../../../../../theme/spacer.dart';
import '../../../../../theme/styles.dart';
import '../../../../../theme/typography.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_loading_screen.dart';

class RedeemVoucherView extends StatelessWidget {
  final bool promoReady;

  const RedeemVoucherView({Key? key, required this.promoReady})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AvailableRedeemOptions>? promotionsList;

    var bloc = context.watch<VoucherCubit>();
    final state = bloc.state;

    final setting = context.watch<SettingsCubit>().state.switchSetting;
    print("setting.myReward  ${setting.myReward } $promoReady ${promotionsList}");
    if ((setting.myReward ?? false)) {
      if (promoReady) {
        promotionsList = bloc.state.redemptionOption?.availableOptions;
      }
    }
    return !state.promoLoaded
        ? const AppLoading()
        : (promoReady && promotionsList == null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kVerticalSpacerSmall,
                  Text(
                    "MYReward",
                    style: kHugeSemiBold.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  kVerticalSpacerMini,
                  Text(
                    "Login to redeem your MYReward Points for further discounts!",
                    style: kMediumRegular.copyWith(),
                  ),
                  kVerticalSpacerMini,

                  ElevatedButton(
                    onPressed: () => showLoginDialog(context),
                    child: Text("Login"),
                  ),
                  kVerticalSpacerSmall,
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ElevatedButton(
                  //     onPressed: () {
                  //       LoginCubit().logout();
                  //     },
                  //     child: Text("logout")),
                  kVerticalSpacerSmall,
                  Text(
                    "MYReward",
                    style: kHugeSemiBold.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  kVerticalSpacerSmall,
                  const Text(
                    'Redeem your MYReward Points from options below!',
                    style: kMediumRegular,
                  ),
                  kVerticalSpacer,
                  for (var currenteItem in promotionsList ?? []) ...[
                    AppCard(
                      customColor: Colors.white,
                      edgeInsets: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Styles.kDartBlack),
                                activeColor: Styles.kActiveColor,
                                value: bloc.getSelectedItem,
                                groupValue: currenteItem,
                                onChanged: (value) {
                                  bloc.selectedItem(currenteItem);
                                }),
                            Text(
                              currenteItem.redeemAmountString,
                              style: kMediumMedium,
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              '${currenteItem.redemptionPoint} points',
                              style: kMediumMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    kVerticalSpacerSmall,
                  ],
                  kVerticalSpacerSmall,
                ],
              );
  }

  showLoginDialog(BuildContext context) {
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
          child: const AppLoadingScreen(message: "Loading"),
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
                      var token =context.read<SummaryCubit>().state.summaryResponse?.token;
                      print("token is $token");
                      if (token != null) {
                        context
                            .read<VoucherCubit>()
                            .getAvailablePromotions(token);
                      }
                      Toast.of(context)
                          .show(message: "Welcome back", success: true);
                      context.router.pop();
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
                  fbKey: JosKeys.gKeysVoucher,
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
}
