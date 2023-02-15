import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AppErrorScreen extends StatelessWidget {
  final String message;
  final bool isDarkBackground;

  const AppErrorScreen({
    Key? key,
    this.message = "Loading",
    this.isDarkBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 70,
              color: isDarkBackground
                  ? Theme.of(context).iconTheme.color
                  : Colors.black,
            ),
            kVerticalSpacer,
            Text(
              "Something wrong with server",
              style: kHugeMedium.copyWith(
                color: isDarkBackground
                    ? Theme.of(context).iconTheme.color
                    : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            kVerticalSpacer,
            Text(
              "Detail:",
              style: kMediumSemiBold.copyWith(
                color: isDarkBackground
                    ? Theme.of(context).iconTheme.color
                    : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            kVerticalSpacerSmall,
            Text(
              message,
              style: kMediumSemiBold.copyWith(
                color: isDarkBackground
                    ? Theme.of(context).iconTheme.color
                    : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            // kVerticalSpacer,
            // Text(
            //   "Contact Us",
            //   style: kMediumSemiBold.copyWith(
            //     color: isDarkBackground
            //         ? Theme.of(context).iconTheme.color
            //         : Colors.black,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
