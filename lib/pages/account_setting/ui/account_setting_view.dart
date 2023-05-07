import 'package:app/app/app_router.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/pages/account_setting/bloc/update_password_cubit.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/pages/auth/pages/signup/ui/password_input.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
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
              title: 'accountDetail.changePassword'.tr(),
              graySubText: true,
              smallerHeaderText: true,
              subtitle: 'accountDetail.verifyIdentity'.tr(),
            ),
            GreyCard(
              child: AppInputPassword(
                name: formNameNewPassword,
                hintText: 'password'.tr(),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText: 'minCharsValidation'.tr())
                ],
              ),
            ),
            kVerticalSpacer,
            kVerticalSpacerSmall,
            PasswordInput(title: 'accountDetail.setNewPassword'.tr()),
            kVerticalSpacerSmall,
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('infoDetail.cancel'.tr()),
            ),
            kVerticalSpacerSmall,
            ElevatedButton(
              onPressed: () => onChangePassword(context),
              child: Text('accountDetail.save'.tr()),
            ),
            kVerticalSpacerMini,
            Center(
              child: TextButton(
                onPressed: () {
                  context.router.push(const DeleteAccountRoute());
                },
                child: Text(
                  'account.deleteAccount'.tr(),
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
