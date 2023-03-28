import 'dart:io';

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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/app_flavor.dart';
import '../../../blocs/profile/profile_cubit.dart';
import '../../../data/api.dart';
import '../../../data/provider/profile_provider.dart';
import '../../../theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class AccountSettingView extends StatelessWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const AccountSettingView({Key? key}) : super(key: key);

  void selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final xFile = XFile(pickedFile.path);
      final file = File(xFile.path);

      var _provider = ProfileProvider(
        Api.client,
        baseUrl: '${AppFlavor.baseUrlApi}/v1/',
      );

      _provider.uploadProfilePicture(file);

      // Do something with the converted File object
    }
  }

  @override
  Widget build(BuildContext context) {
    String? currency = context
        .watch<ProfileCubit>()
        .state
        .profile
        ?.userProfile
        ?.profileImageURL;

    return FormBuilder(
      key: _fbKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /*if (currency != null) ...[
              Image.memory(base64Decode(currency ?? '')),
            ] else ...[
              TextButton(
                onPressed: () {
                  selectImage();
                },
                child: const Text('Select Image'),
              ),
            ],*/


            const FormHeader(
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
            const PasswordInput(title: "Set New Password"),
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
                  context.router.push(const DeleteAccountRoute());
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
