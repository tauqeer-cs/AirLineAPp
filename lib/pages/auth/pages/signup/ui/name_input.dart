import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class NameInput extends StatelessWidget {
  final Function(String? newTitle)? onTitleChanged;
  final String? title;
  final String? subText;
  final bool smallerSubText, isSignUp;
  final EdgeInsets? customGreyEdgeInsets;
  final String? initialTitle;
  final String? firstNameInitValue;
  final String? lastNameInitValue;
  final double greyMargin;

  const NameInput({
    Key? key,
    this.title,
    this.subText,
    this.smallerSubText = false,
    required this.isSignUp,
    this.greyMargin = 8.0,
    this.customGreyEdgeInsets,
    this.firstNameInitValue,
    this.lastNameInitValue,
    this.initialTitle,
    this.onTitleChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: title ?? 'fullNameQuestion'.tr(),
          subtitle: subText ?? 'fullNameDesc'.tr(),
          graySubText: true,
        ),
        GreyCard(
          margin: 6,
          edgeInsets: const EdgeInsets.all(8),
          child: Column(
            children: [
              AppDropDown<String>(
                items: availableTitle,
                defaultValue: initialTitle ?? 'mr'.tr(),
                sheetTitle: 'title'.tr(),
                onChanged: (value) {
                  if (isSignUp) {
                    context.read<SignupCubit>().editTitle(value);
                  }
                  onTitleChanged?.call(value);
                },
              ),
              kVerticalSpacer,
              AppInputText(
                isRequired: false,
                textInputType: TextInputType.name,
                name: formNameFirstName,
                hintText: 'firstName'.tr(),
                initialValue: firstNameInitValue,
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              kVerticalSpacer,
              AppInputText(
                isRequired: false,
                textInputType: TextInputType.name,
                name: formNameLastName,
                initialValue: lastNameInitValue,
                hintText: 'lastName'.tr(),
                validators: [
                  FormBuilderValidators.required(),
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
