import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/resend_email_request.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/pages/auth/pages/signup/ui/signup_container.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CompleteSignupPage extends StatelessWidget {
  final SignupRequest signupRequest;
  final step = 3;

  const CompleteSignupPage({Key? key, required this.signupRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/design/signup_bg.png",
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                kVerticalSpacer,
                Row(
                  children: [
                    BackButton(
                      onPressed: () => AutoRouter.of(context).pop(),
                      color: Colors.white,
                    ),
                    const Expanded(
                        child: Center(child: AppLogoWidget(useWhite: true))),
                    const BackButton(color: Colors.transparent),
                  ],
                ),
                kVerticalSpacer,
                Expanded(
                  child: SignupContainer(
                    name: signupRequest.firstName,
                    step: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${'signUp3.congrats'.tr()} ${signupRequest.firstName}",
                            style: kGiantHeavy.copyWith(fontSize: 26),
                          ),
                          kVerticalSpacerSmall,
                          Visibility(
                            visible: step != 3,
                            child: Text(
                              step == 1
                                  ? "signUpDescription".tr()
                                  : "worryNot".tr(),
                              style: kMediumRegular.copyWith(
                                  color: Styles.kSubTextColor, fontSize: 16),
                            ),
                          ),
                          Text(
                            "signUp3.congratsDesc".tr(),
                            style: kLargeRegular.copyWith(
                              color: Styles.kSubTextColor,
                            ),
                          ),
                          kVerticalSpacerSmall,
                          Text(
                            "${'signUp3.checkEmail1'.tr()} ${(signupRequest.email ?? "").sensorEmailFront()} ",
                            style: kLargeHeavy.copyWith(
                              color: Styles.kSubTextColor,
                            ),
                          ),
                          kVerticalSpacerSmall,
                          Text(
                            "clickResendLinkMessage".tr(),
                            style: kLargeRegular.copyWith(
                              color: Styles.kSubTextColor,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              AuthenticationRepository().sendEmail(
                                ResendEmailRequest(email: signupRequest.email),
                              );
                              Toast.of(context).show(
                                  success: true,
                                  message: "signUp3.emailSuccess".tr());
                            },
                            child: Text(
                              "signUp3.resendLink".tr(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
