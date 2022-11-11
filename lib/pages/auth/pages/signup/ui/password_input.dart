import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/utils/validator_utils.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class PasswordInput extends StatelessWidget {
  final String? title;
  const   PasswordInput({Key? key, this.title}) : super(key: key);
  static final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: title ?? "Let's create your password.",
          graySubText: true,
          smallerHeaderText: true,
          subtitle:
              "Your password cannot contain part of your first or last name. It must contain 8 characters minimum, with the following requirements ",
        ),
        const UnorderedList([
          "Lower case letter",
          "Upper case letter",
          "Number (0-9)",
          "Symbol (e.g !@#\$%^&*)",
        ]),
        kVerticalSpacer,
        GreyCard(
          edgeInsets: EdgeInsets.all(8),

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
