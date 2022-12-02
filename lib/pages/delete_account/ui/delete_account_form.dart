import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/delete_account/bloc/delete_account_cubit.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../theme/theme.dart';

const formPassword = "password_delete";

class DeleteAccountForm extends StatelessWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const DeleteAccountForm({Key? key}) : super(key: key);

  onRequest(BuildContext context) {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final email = context.read<AuthBloc>().state.user?.email ?? "";
      final password = value[formPassword];
      context.read<DeleteAccountCubit>().deleteAccount(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _fbKey,
          child: GreyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                  child: Text("Delete Your Account?", style: kGiantHeavy),
                ),
                kVerticalSpacerMini,
                Text(
                  "All your data will be deleted. are you sure?",
                  style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                ),
                kVerticalSpacer,
                AppInputPassword(
                  name: formPassword,
                  hintText: 'Password',
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.match(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        errorText:
                            'Minimum 8 characters with at least one lower case letter, upper case letter, a number and a symbol.'),
                  ],
                ),
                kVerticalSpacerSmall,
                ElevatedButton(
                    onPressed: () {
                      onRequest(context);
                    },
                    child: const Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
