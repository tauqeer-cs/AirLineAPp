import 'package:app/models/country.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/utils/validator_utils.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:app/widgets/forms/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);
  static final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: "Let's create your password.",
          subtitle:
              "Your password cannot contain part of your first or last name. It must contain 8 characters minimum, with the following requirements ",
        ),
        UnorderedList([
          "Lower case letter",
          "Upper case letter",
          "Number (0-9)",
          "Symbol (e.g !@#\$%^&*)",
        ]),
        kVerticalSpacer,
        GreyCard(
          child: Column(
            children: [
              AppInputPassword(
                textEditingController: pass,
                name: formNamePassword,
                hintText: 'Password',
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText:
                      'Minimum 8 characters with at least one lower case letter, upper case letter, a number and a symbol.')
                ],
              ),
              kVerticalSpacer,
              AppInputPassword(
                name: formNameConfirmPassword,
                hintText: 'Confirm Password',
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText:
                      'Minimum 8 characters with at least one lower case letter, upper case letter, a number and a symbol.'),
                      (value) {
                    return ValidatorUtils.checkTwoField(
                      value,
                      pass.text,
                    );
                  },
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
}
