import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AppErrorWidget({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: kHugeHeavy,
              textAlign: TextAlign.center,
            ),
            kVerticalSpacerSmall,
            Text(
              subtitle ?? "",
              style: kLargeRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
