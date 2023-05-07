import 'package:app/app/app_router.dart';
import 'package:app/pages/auth/ui/login_form.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:app/widgets/containers/version_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    Key? key,
    this.showContinueButton = false,
  }) : super(key: key);

  final bool showContinueButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: kPageHorizontalPadding,
        children: [
          kVerticalSpacer,
          Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      const Center(child: AppLogoWidget(useWhite: true)),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            context.router.push(
                              const MoreOptionsRoute(),
                            );
                          },
                          child: Text(
                            'moreInfo'.tr(),
                            style: kSmallMedium.copyWith(
                                color: Styles.kCanvasColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  kVerticalSpacer,
                  Text(
                    'welcomeBack'.tr(),
                    style: kGiantRegular.copyWith(color: Colors.white),
                  ),
                ],
              ),
              kVerticalSpacer,
              GlassCard(
                child: LoginForm(
                  fbKey: JosKeys.gKeysAuth,
                  showContinueButton: showContinueButton,
                  formEmailLoginName: "emailAuth",
                  formPasswordLoginName: "passwordAuth",
                ),
              ),
              kVerticalSpacer,
              // Row(
              //   children: [
              //     Expanded(child: AppDividerWidget(color: Colors.white)),
              //     kHorizontalSpacer,
              //     Text("Or continue with", style: kMediumSemiBold.copyWith(color: Colors.white),),
              //     kHorizontalSpacer,
              //     Expanded(child: AppDividerWidget(color: Colors.white)),
              //   ],
              // ),
              // kVerticalSpacer,
              // Visibility(
              //   visible: Platform.isIOS,
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 45,
              //     child: SignInButton(
              //       Buttons.Apple,
              //       onPressed: () => context.read<LoginCubit>().loginWithApple(),
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              //     ),
              //   ),
              // ),
              // kVerticalSpacerSmall,
              // SizedBox(
              //   width: double.infinity,
              //   height: 45,
              //   child: SignInButton(
              //     Buttons.GoogleDark,
              //     onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              //   ),
              // ),
              kVerticalSpacerHuge,
              kVerticalSpacerHuge,
              const VersionWidget(
                textColor: Colors.white,
              ),
            ],
          ),

          /*kVerticalSpacer,
          AppDividerWidget(),
          kVerticalSpacer,
          Text("Don't have account?"),*/
        ],
      ),
    );
  }
}
