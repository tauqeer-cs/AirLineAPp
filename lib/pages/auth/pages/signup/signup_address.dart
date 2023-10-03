import 'package:app/data/requests/signup_request.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_account.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/personal_detail/address_input.dart';
import 'package:app/pages/auth/pages/signup/ui/personal_detail/dob_input.dart';
import 'package:app/pages/auth/pages/signup/ui/personal_detail/gender_input.dart';
import 'package:app/pages/auth/pages/signup/ui/signup_container.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/date_symbol_data_local.dart';

class SignupAddressPage extends StatelessWidget {
  const SignupAddressPage({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();
  final step = 2;

  void onSignup(BuildContext context) {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;

      String addressString = value[formNameAddress] ?? '';
      String addressCityString = value[formNameCity] ?? '';
      String poString = value[formNamePostCode] ?? '';
      String stateString = value[formNameState] ?? '';

      //    final newData = state.signupRequest.copyWith(country: country);

      String countryString = context.read<SignupCubit>().state.signupRequest.country ?? '';

      bool isValidAddress = true;

      if (addressString.isNotEmpty) {
        if (addressCityString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameCity,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (poString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNamePostCode,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (stateString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameState,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (countryString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameCountry,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }
      }

      else
        if (addressCityString.isNotEmpty) {
        if (addressString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameAddress,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (poString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNamePostCode,
            errorText: 'personalInfo.required'.tr(),
          );

          isValidAddress = false && isValidAddress;
        }
        if (stateString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameState,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }
        if (countryString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameCountry,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }
      } else if (poString.isNotEmpty) {
        if (addressString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameAddress,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (addressCityString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameCity,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (stateString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameState,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (countryString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameCountry,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }


      } else if (stateString.isNotEmpty) {
        if (poString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNamePostCode,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (addressString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameAddress,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }

        if (addressCityString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameCity,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }
        if (countryString.isEmpty) {
          _fbKey.currentState!.invalidateField(
            name: formNameCountry,
            errorText: 'personalInfo.required'.tr(),
          );
          isValidAddress = false && isValidAddress;
        }
      }
        else if (countryString.isNotEmpty) {
          if (poString.isEmpty) {
            _fbKey.currentState!.invalidateField(
              name: formNamePostCode,
              errorText: 'personalInfo.required'.tr(),
            );
            isValidAddress = false && isValidAddress;
          }

          if (addressString.isEmpty) {
            _fbKey.currentState!.invalidateField(
              name: formNameAddress,
              errorText: 'personalInfo.required'.tr(),
            );
            isValidAddress = false && isValidAddress;
          }

          if (addressCityString.isEmpty) {
            _fbKey.currentState!.invalidateField(
              name: formNameCity,
              errorText: 'personalInfo.required'.tr(),
            );
            isValidAddress = false && isValidAddress;
          }
          if (stateString.isEmpty) {
            _fbKey.currentState!.invalidateField(
              name: formNameState,
              errorText: 'personalInfo.required'.tr(),
            );
            isValidAddress = false && isValidAddress;
          }
        }
        else {
        // If address is empty, invalidate all address-related fields if they are not empty.
      }

      if (!isValidAddress) {
        return;
      }

      String state = (value[formNameState] ?? '');
      if (state.isNotEmpty) {
        state = state.substring(0, 2);
      }



      final signupRequest = SignupRequest(
        city: value[formNameCity],
        address: value[formNameAddress],
        dob: value[formNameDob],
        postCode: value[formNamePostCode],
        state: true ? state : (value[formNameState] ?? ''),
      );
      context.read<SignupCubit>().signup(signupRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();

    initializeDateFormatting(locale, null);

    return Stack(
      children: [
        Image.asset(
          "assets/images/design/signup_bg.png",
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              kVerticalSpacerHuge,
              Row(
                children: [
                  BackButton(
                    onPressed: () => AutoRouter.of(context).pop(),
                    color: Colors.white,
                  ),
                  const Expanded(
                    child: Center(child: AppLogoWidget(useWhite: true)),
                  ),
                  const BackButton(color: Colors.transparent),
                ],
              ),
              kVerticalSpacer,
              Expanded(
                child: SignupContainer(
                  step: step,
                  child: FormBuilder(
                    autoFocusOnValidationFailure: true,
                    key: _fbKey,
                    child: SingleChildScrollView(
                      padding: kPageHorizontalPaddingBig,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SignupHeader(step: 2),
                          Visibility(
                            visible: step != 3,
                            child: Text(
                              step == 1
                                  ? 'signUp1.signUpDesc'.tr()
                                  : 'worryNot'.tr(),
                              style: kMediumRegular.copyWith(
                                  color: Styles.kSubTextColor, fontSize: 16),
                            ),
                          ),
                          kVerticalSpacer,
                          GenderInput(
                            onChanged: (value) => context
                                .read<SignupCubit>()
                                .editGender(value ?? 'male'.tr()),
                          ),
                          kVerticalSpacer,
                          AppDividerWidget(color: Styles.kTextColor),
                          kVerticalSpacer,
                          const DobInput(),
                          kVerticalSpacer,
                          AppDividerWidget(color: Styles.kTextColor),
                          kVerticalSpacer,
                           AddressInput(),
                          kVerticalSpacer,
                          AppDividerWidget(color: Styles.kTextColor),
                          kVerticalSpacer,
                          ElevatedButton(
                            onPressed: () {
                              //context
                              //  .read<SignupCubit>().valideAddress();

                              onSignup(context);
                            },
                            child: Text('continue'.tr()),
                          ),
                          kVerticalSpacer,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
