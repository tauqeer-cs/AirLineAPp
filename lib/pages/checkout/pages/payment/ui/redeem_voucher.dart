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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../blocs/manage_booking/manage_booking_cubit.dart';
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

  final bool isManageBooking;

  final String? currency;


  const RedeemVoucherView({Key? key, required this.promoReady,this.currency,  this.isManageBooking = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AvailableRedeemOptions>? promotionsList;

    var bloc = context.watch<VoucherCubit>();
    final state = bloc.state;

    ManageBookingCubit? mmBbloc;
    final setting = context.watch<SettingsCubit>().state.switchSetting;
    print("setting.myReward  ${setting.myReward } $promoReady ${promotionsList}");
    if(isManageBooking) {

      mmBbloc = context.watch<ManageBookingCubit>();;

      if (promoReady) {
          promotionsList = mmBbloc.state.redemptionOption?.availableOptions;
        }

    }
    else {
      if ((setting.myReward ?? false)) {
        if (promoReady) {
          promotionsList = bloc.state.redemptionOption?.availableOptions;
        }
      }

    }

    final user = context.read<AuthBloc>().state.user;

    return
      user  == null ? Column(
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
            "loginToRedeemDiscounts".tr(),
            style: kMediumRegular.copyWith(),
          ),
          kVerticalSpacerMini,

          ElevatedButton(
            onPressed: () async {
              showLoginDialog(context);

            },
            child:  Text("logIn".tr()),
          ),
          kVerticalSpacerSmall,
        ],
      ) :
      ((!state.promoLoaded && isManageBooking == false))
          ? const AppLoading()
          : (promoReady && promotionsList == null)
          ? Container()
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
          Text(
            'paymentView.myrewardDesc'.tr(),
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
                        value: isManageBooking ? mmBbloc?.state.rewardItem : bloc.getSelectedItem,
                        groupValue: currenteItem,
                        onChanged: (value) {
                          if(isManageBooking) {

                            mmBbloc?.selectedRewardItem(currenteItem);



                          }
                          else {
                            bloc.selectedItem(currenteItem);
                          }

                        }),
                    Text(
                      currenteItem.redeemAmountString(currency ?? 'MYR'),
                      style: kMediumMedium,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      '${currenteItem.redemptionPoint} ${'paymentView.points'.tr()}',
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
          child:  AppLoadingScreen(message: 'loading'.tr()),
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
                          .show(message: 'welcomeBack'.tr(), success: true);
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
                  formPasswordLoginName: "passwordBooking", fromPopUp: true,
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
          title: "verifyEmail.emailVerifyTitle".tr(),
          subtitle:
          "verifyEmail.emailVerifyDesc".tr(),
          confirmText: "verifyEmail.resend".tr(),
          onConfirm: () {
            AuthenticationRepository()
                .sendEmail(ResendEmailRequest(email: email));
          },
          child: Column(
            children: [
              Text(
                "${'verifyEmail.emailVerifyLink1'.tr()} ${email.sensorEmail()}. ${'verifyEmail.emailVerifyLink2'.tr()}",
                style: kMediumHeavy,
              ),
              kVerticalSpacer,
              Text(
                "verifyEmail.emailVerifyLink3".tr(),
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
