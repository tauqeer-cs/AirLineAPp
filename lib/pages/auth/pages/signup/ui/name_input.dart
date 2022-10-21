import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class NameInput extends StatelessWidget {
  const NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: "What's your full name?",
          subtitle: "Please enter it as stated in your MyKad/Passport ",
        ),
        FormBuilderDropdown<String>(
          name: formNameTitle,
          initialValue: "Mr.",
          items: availableTitle
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
        AppInputText(
          isRequired: false,
          textInputType: TextInputType.name,
          name: formNameFirstName,
          hintText: 'First Name',
          validators: [
            FormBuilderValidators.required(),
          ],
        ),

        kVerticalSpacer,
        AppInputText(
          isRequired: false,
          textInputType: TextInputType.name,
          name: formNameLastName,
          hintText: 'Last Name',
          validators: [
            FormBuilderValidators.required(),
          ],
        ),
      ],
    );
  }
}
