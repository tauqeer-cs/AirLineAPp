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
        Center(
          child: Container(
            width: 80,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFFDBDBDB),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        Padding(
          padding: edgeInsets ?? const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "",
                style: kMediumHeavy.copyWith(letterSpacing: 1.5),
              ),
              // IconButton(
              //   icon: const Icon(Icons.close),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              // )
            ],
          ),
        ),
        kVerticalSpacer,
        Padding(
          padding: edgeInsets ?? const EdgeInsets.symmetric(horizontal: 16.0),
          child: const AppDividerWidget(color: Colors.white),
        ),
      ],
    );
  }
}
