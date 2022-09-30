import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../theme/theme.dart';

class AppLoadingScreen extends StatelessWidget {
  final String message;

  const AppLoadingScreen({Key? key, this.message = "Loading"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(color: Styles.kDarkContainerColor),
            kVerticalSpacer,
            Text(
              message,
              style: kHugeMedium.copyWith(
                color: Styles.kDarkContainerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppLoading extends StatelessWidget {
  const AppLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: Styles.kPrimaryColor,
    );
  }
}
