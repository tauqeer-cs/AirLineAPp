import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GenderInput extends StatefulWidget {
  final Function(String?) onChanged;

  const GenderInput({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<GenderInput> createState() => _GenderInputState();
}

class _GenderInputState extends State<GenderInput> {
  String? selected = "Male";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: "genderQuestion".tr(),
          subtitle: "genderDesc".tr(),
        ),
        Text("gender".tr(), style: kLargeSemiBold),
        kVerticalSpacer,
        InkWell(
          onTap: () {
            setState(() {
              selected = "Male";
            });
            widget.onChanged("Male");
          },
          child: GreyCard(
            edgeInsets: const EdgeInsets.all(8),
            child: Row(
              children: [
                Radio<String?>(
                  value: "Male",
                  visualDensity: const VisualDensity(
                    horizontal: -2,
                    vertical: -2,
                  ),
                  groupValue: selected,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                    });
                    widget.onChanged(value);
                  },
                ),
                kHorizontalSpacerMini,
                Text("male".tr()),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selected = "Female";
            });
            widget.onChanged("Female");
          },
          child: GreyCard(
            edgeInsets: const EdgeInsets.all(8),
            child: Row(
              children: [
                Radio<String?>(
                  value: "Female",
                  visualDensity: const VisualDensity(
                    horizontal: -2,
                    vertical: -2,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  groupValue: selected,
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                    });
                    widget.onChanged(value);
                  },
                ),
                kHorizontalSpacerMini,
                Text("female".tr()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
