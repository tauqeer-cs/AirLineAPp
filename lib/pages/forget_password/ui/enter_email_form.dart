import 'package:app/pages/forget_password/bloc/forget_password_cubit.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../theme/theme.dart';

const formEmail = "email_reset";

class EnterEmailForm extends StatelessWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const EnterEmailForm({Key? key}) : super(key: key);

  onRequest(BuildContext context) {
    //context.router.replace(CompleteSignupRoute(signupRequest: SignupRequest()));
    //return;
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
      final email = value[formEmail];
      context.read<ForgetPasswordCubit>().sendEmailRequest(email);
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
                  padding: EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 0),
                  child: Text("Forgot your password?", style: kGiantHeavy),
                ),
                kVerticalSpacerMini,
                Text(
                  "Enter the email you registered with. ",
                  style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                ),
                kVerticalSpacer,
                AppInputText(
                  name: formEmail,
                  hintText: "Email",
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
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
