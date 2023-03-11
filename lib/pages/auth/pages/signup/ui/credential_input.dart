import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/validate_email/validate_email_cubit.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../signup_wrapper.dart';

class CredentialInput extends StatelessWidget {
  final FocusNode? focusNode;

  const CredentialInput({Key? key, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormHeader(
          title: "Let's create your credentials.",
        ),
        GreyCard(
          edgeInsets: const EdgeInsets.all(8),
          child: Column(
            children: [
              BlocBuilder<ValidateEmailCubit, GenericState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          AppInputText(
                            maxLength: 45,
                            isRequired: false,
                            focusNode: focusNode,
                            textInputType: TextInputType.emailAddress,
                            name: formNameEmail,
                            hintText: 'Email Address',
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ],
                            // prefix: state.blocState == BlocState.loading
                            //     ? AppLoading(size: 20)
                            //     : SizedBox(),
                          ),
                          Visibility(
                            visible: state.blocState == BlocState.loading,
                            child: Positioned.fill(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.black.withOpacity(0.3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    AppLoading(
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: state.blocState == BlocState.failed,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                          child: Text(state.message, style: kSmallSemiBold.copyWith(color: Styles.kActiveColor),),
                        ),
                      ),
                    ],
                  );
                },
              ),
              kVerticalSpacer,
              AppCountriesDropdown(
                isPhoneCode: true,
                hintText: "Phone",
                initialValue: Country.defaultCountry,
                onChanged: (country) {
                  context
                      .read<SignupCubit>()
                      .editPhoneCode(country?.phoneCode ?? "");
                },
              ),
              kVerticalSpacer,
              AppInputText(
                name: formNamePhone,
                textInputType: TextInputType.number,
                hintText: "Phone Number",
                validators: [FormBuilderValidators.required()],
              ),
              kVerticalSpacer,
            ],
          ),
        ),
      ],
    );
  }
}
