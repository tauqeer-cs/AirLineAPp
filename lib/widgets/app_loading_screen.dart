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
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(color: Styles.kPrimaryColor),
              kVerticalSpacer,
              Text(
                message,
                style: kHugeMedium.copyWith(
                  color: Styles.kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppLoading extends StatelessWidget {
  final Color? color;
  final double? size;

  const AppLoading({
    Key? key,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color ?? Styles.kPrimaryColor,
      size: size ?? 50,
    );
  }
}
