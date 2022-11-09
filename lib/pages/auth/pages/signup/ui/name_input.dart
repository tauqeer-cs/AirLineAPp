import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:app/widgets/forms/form_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class NameInput extends StatelessWidget {
  Function(String? newTitle)? onTitleChanged;

  final String? title;
  final String? subText;
  final bool smallerSubText;
  final EdgeInsets? customGreyEdgeInsets;

  final String? initialTitle;
  final String? firstNameInitValue;
  final String? lastNameInitValue;

  final double greyMargin;

  NameInput(
      {Key? key,
      this.title,
      this.subText,
      this.smallerSubText = false,
      this.greyMargin = 8.0,
      this.customGreyEdgeInsets,
      this.firstNameInitValue,
      this.lastNameInitValue,
      this.initialTitle,
      this.onTitleChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: title ?? "What's your full name?",
          subtitle:
              subText ?? "Please enter it as stated in your MyKad/Passport ",
          graySubText: true,
          smallerHeaderText: true,
        ),
        GreyCard(
          margin: greyMargin,
          edgeInsets: customGreyEdgeInsets ?? const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppDropDown<String>(
                  items: availableTitle,
                  defaultValue: initialTitle ?? "Mr.",
                  sheetTitle: "Title",
                  onChanged: (value) {
                    context.read<SignupCubit>().editTitle(value);

                    onTitleChanged?.call(value);


                  },
                ),
                kVerticalSpacer,
                AppInputText(
                  isRequired: false,
                  textInputType: TextInputType.name,
                  name: formNameFirstName,
                  hintText: 'First Name',
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
                  hintText: 'Last Name',
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),
                kVerticalSpacer,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
