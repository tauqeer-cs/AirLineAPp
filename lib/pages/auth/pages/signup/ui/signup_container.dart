import 'dart:ui';

import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class SignupContainer extends StatelessWidget {
  final Widget child;
  final int step;
  final String? name;

  const SignupContainer(
      {Key? key, required this.child, required this.step, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(40),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.01,
                  0.1,
                ],
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpacerSmall,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: step == 3
                    ? Text(
                        "Congrats $name",
                        style: kGiantHeavy.copyWith(
                          color: Styles.kPrimaryColor,
                          fontSize: 26,
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              step == 1
                                  ? "Sign Up"
                                  : "Personal Info (Optional)",
                              style: kGiantHeavy.copyWith(
                                color: Styles.kPrimaryColor,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          kHorizontalSpacer,
                          CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                step == 1 ? Styles.kActiveColor : Colors.white,
                            child: Text(
                              "1",
                              style: kLargeHeavy.copyWith(
                                color: step == 1
                                    ? Colors.white
                                    : Styles.kDisabledButton,
                              ),
                            ),
                          ),
                          kHorizontalSpacerSmall,
                          kHorizontalSpacerMini,
                          CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                step == 2 ? Styles.kActiveColor : Colors.white,
                            child: Text(
                              "2",
                              style: kLargeHeavy.copyWith(
                                color: step == 2
                                    ? Colors.white
                                    : Styles.kDisabledButton,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Visibility(
                visible: step != 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
                  child: Text(
                    step == 1
                        ? "Tell us more about yourself."
                        : "Worry not, all questions are in accordance with MYAirline guidelines",
                    style: kMediumHeavy.copyWith(
                        color: Styles.kSubTextColor, fontSize: 16),
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
