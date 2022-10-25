import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
          title: "What's your gender?",
          subtitle: "Select the gender as stated on your MyKad/Passport ",
        ),
        Text("Gender", style: kLargeSemiBold),
        kVerticalSpacer,
        GestureDetector(
          onTap: () {
            setState(() {
              selected = "Male";
            });
            widget.onChanged("Male");
          },
          child: GreyCard(
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
                Text("Male"),
              ],
            ),
          ),
        ),
        kVerticalSpacer,
        GestureDetector(
          onTap: () {
            setState(() {
              selected = "Female";
            });
            widget.onChanged("Female");
          },
          child: GreyCard(
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
                Text("Female"),
              ],
            ),
          ),
        ),
        kVerticalSpacer,
      ],
    );
  }
}
