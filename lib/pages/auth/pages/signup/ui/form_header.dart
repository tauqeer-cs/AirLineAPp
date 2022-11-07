import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool graySubText;
  final bool smallerHeaderText;

  final bool midSizedText;
  final bool noSpaceSubText;


  const FormHeader(
      {Key? key,
      this.title,
      this.subtitle,
      this.graySubText = false,
      this.smallerHeaderText = false, this.noSpaceSubText = false, this.midSizedText = false,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != null,
          child: Column(
            children: [
              Text(title ?? "", style: midSizedText ? k18SemiBold  : (smallerHeaderText ? kLargeHeavy : kHugeSemiBold)),
              kVerticalSpacerMini,
            ],
          ),
        ),

        if(noSpaceSubText) ... [

          kVerticalSpacerMini,
        ]
        else if (graySubText) ...[
          Text(
            subtitle ?? '',
            style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
          ),
          kVerticalSpacer,

        ] else ...[

          Visibility(
            visible: subtitle != null,
            child: Text(subtitle ?? ""),
          ),
          kVerticalSpacer,

        ],
      ],
    );
  }
}
