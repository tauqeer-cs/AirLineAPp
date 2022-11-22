
import 'package:app/data/requests/signup_request.dart';
import 'package:app/pages/auth/pages/signup/ui/signup_container.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CompleteSignupPage extends StatelessWidget {
  final SignupRequest signupRequest;
  final step =3;

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
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Congrats ${signupRequest.firstName}",
                            style: kGiantHeavy.copyWith(
                              color: Styles.kPrimaryColor,
                              fontSize: 26,
                            ),
                          ),
                          Visibility(
                            visible: step != 3,
                            child: Text(
                              step == 1
                                  ? "Tell us more about yourself."
                                  : "Worry not, all questions are in accordance with MYAirline guidelines",
                              style: kMediumRegular.copyWith(
                                  color: Styles.kSubTextColor, fontSize: 16),
                            ),
                          ),
                          Text(
                            '''Please check your email for a link to verify your registration.

Please sign back in after you complete the verification of your email address.''',
                            style: kLargeRegular.copyWith(
                                color: Styles.kSubTextColor),
                          ),
                          Spacer(),
                          ElevatedButton(onPressed: ()=>context.router.pop(), child: Text("Done"))
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
