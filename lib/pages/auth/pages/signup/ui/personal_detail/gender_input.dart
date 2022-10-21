import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class GenderInput extends StatelessWidget {
  const GenderInput({Key? key}) : super(key: key);

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
        FormBuilderDropdown<String>(
          name: formNameTitle,
          decoration: InputDecoration(
            hintText: "Select gender"
          ),
          items: ["Male", "Female"]
              .map(
                (e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ),
          )
              .toList(),
          validator: FormBuilderValidators.required(),
        ),
        kVerticalSpacer,

      ],
    );
  }
}
