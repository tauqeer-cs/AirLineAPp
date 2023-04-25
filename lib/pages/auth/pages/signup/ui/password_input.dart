import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/utils/validator_utils.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/unordered_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class PasswordInput extends StatelessWidget {
  final String? title;
  const PasswordInput({Key? key, this.title}) : super(key: key);
  static final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: title ?? 'passwordTitle'.tr(),
          graySubText: true,
          smallerHeaderText: true,
          subtitle: 'passwordDesc1'.tr(),
        ),
        UnorderedList([
          'passwordDesc2'.tr(),
          'passwordDesc3'.tr(),
          'passwordDesc3'.tr(),
          'passwordDesc4'.tr(),
        ]),
        kVerticalSpacer,
        GreyCard(
          edgeInsets: const EdgeInsets.all(8),
          child: Column(
            children: [
              AppInputPassword(
                textEditingController: pass,
                name: formNamePassword,
                hintText: 'password'.tr(),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText: 'signUp1.minCharsValidation'.tr())
                ],
              ),
              kVerticalSpacer,
              AppInputPassword(
                name: formNameConfirmPassword,
                hintText: 'signUp1.passwordConfirm'.tr(),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText: 'signUp1.minCharsValidation'.tr()),
                  (value) {
                    return ValidatorUtils.checkTwoField(
                      value,
                      pass.text,
                    );
                  },
                ],
              ),
              kVerticalSpacer,
            ],
          ),
        ),
      ],
    );
  }
}
