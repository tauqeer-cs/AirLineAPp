import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const FormHeader({Key? key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != null,
          child: Column(
            children: [
              Text(title ?? "", style: kHugeSemiBold),
              kVerticalSpacerMini,
            ],
          ),
        ),
        Visibility(
          visible: subtitle != null,
          child: Text(subtitle ?? ""),
        ),
        kVerticalSpacer,
      ],
    );
  }
}
