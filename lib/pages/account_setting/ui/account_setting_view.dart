import 'package:app/app/app_router.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/pages/account_setting/bloc/update_password_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/pages/auth/pages/signup/ui/password_input.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../theme/theme.dart';

class AccountSettingView extends StatelessWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const AccountSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHeader(
              title: "Change Password",
              graySubText: true,
              smallerHeaderText: true,
              subtitle: "To verify your identity, enter your current password.",
            ),
            GreyCard(
              child: AppInputPassword(
                name: formNameNewPassword,
                hintText: 'Password',
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText:
                          'Minimum 8 characters with at least one lower case letter, upper case letter, a number and a symbol.')
                ],
              ),
            ),
            kVerticalSpacer,
            kVerticalSpacerSmall,
            PasswordInput(title: "Set New Password"),
            kVerticalSpacerSmall,
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            kVerticalSpacerSmall,
            ElevatedButton(
              onPressed: () => onChangePassword(context),
              child: const Text("Save"),
            ),
            kVerticalSpacerMini,
            Center(
              child: TextButton(
                onPressed: () {
                  context.router.push(DeleteAccountRoute());
                },
                child: Text(
                  "Delete Account",
                  style: kMediumRegular.copyWith(color: Styles.kBorderColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onChangePassword(BuildContext context) {
    final email = context.read<AuthBloc>().state.user?.email;
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final updatePassword = UpdatePasswordRequest(
        newPassword: value[formNamePassword],
        previousPassword: value[formNameNewPassword],
        email: email,
      );
      context.read<UpdatePasswordCubit>().updatePassword(updatePassword);
    }
  }
}
