import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:flutter/material.dart';

class AppSheetHandler extends StatelessWidget {
  final String? title;
  final EdgeInsets? edgeInsets;
  const AppSheetHandler({Key? key, this.title, this.edgeInsets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //kVerticalSpacer,
        kVerticalSpacerMini,
        Padding(
          padding: edgeInsets ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "",
                style: kMediumHeavy,
              ),

            ],
          ),
        ),
        kVerticalSpacerMini,
        Padding(
          padding: edgeInsets ?? const EdgeInsets.symmetric(horizontal: 8.0),
          child: const AppDividerWidget(color: Colors.white),
        ),
      ],
    );
  }
}
