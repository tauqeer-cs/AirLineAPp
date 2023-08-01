import 'package:app/app/app_router.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/forms/app_input_password.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../blocs/profile/profile_cubit.dart';

class JosKeys {
  static final gKeysAuth = GlobalKey<FormBuilderState>();
  static final gKeysSearch = GlobalKey<FormBuilderState>();
  static final gKeysBooking = GlobalKey<FormBuilderState>();
  static final gKeysVoucher = GlobalKey<FormBuilderState>();

}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.showContinueButton,
    required this.formEmailLoginName,
    required this.formPasswordLoginName,
    required this.fbKey, required this.fromPopUp,
  }) : super(key: key);
  final GlobalKey<FormBuilderState> fbKey;
  final String formEmailLoginName;
  final String formPasswordLoginName;
  final bool showContinueButton;
  final bool fromPopUp;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  onLogin(BuildContext context,bool fromPopUp) async {
    if (widget.fbKey.currentState!.saveAndValidate()) {
      setState(() {
        isLoading = true;
      });
      final value = widget.fbKey.currentState!.value;
      final email = value[widget.formEmailLoginName];
      final password = value[widget.formPasswordLoginName];
      var result = await context
          .read<LoginCubit>()
          .logInWithCredentialsFromPopUp(email, password,(){

            print('');

      });



      if(fromPopUp)
      {



        if(result == true) {
          await  context.read<ProfileCubit>().getProfile();
        }
        else {
          setState(() {
            isLoading = false;
          });

          return;

        }


      }
      else {

        context.read<ProfileCubit>().getProfile();
      }
      setState(() {
        isLoading = false;
      });

      await context.read<LoginCubit>().changeStatus();
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var logicCubit =  context.read<LoginCubit>();

    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: widget.fbKey,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                MyFlutterApp.icon0vector49301__1_,
                color: Styles.kPrimaryColor,
                size: 20,
              ),
              kHorizontalSpacerMini,
              Text(
                'logIn'.tr(),
                style: kHugeMedium.copyWith(color: Styles.kPrimaryColor),
              ),
            ],
          ),
          Visibility(
            visible: widget.showContinueButton,
            child: Column(
              children: [
                kVerticalSpacer,
                ElevatedButton(
                    onPressed: () => context.router.pop(),
                    child:
                     Text('continueGuest'.tr())),
                kVerticalSpacerSmall,
                Row(
                  children: [
                    Expanded(
                      child: AppDividerWidget(
                        color: Styles.kSubTextColor,
                      ),
                    ),
                    kHorizontalSpacerMini,
                     Text(
                        'loginVerify.or'.tr()
                    ),
                    kHorizontalSpacerMini,
                    Expanded(
                        child: AppDividerWidget(
                          color: Styles.kSubTextColor,
                        )),
                  ],
                ),
                kVerticalSpacerSmall,
              ],
            ),
          ),
          kVerticalSpacerSmall,
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ), // set the background color here
            child: AppInputText(
              topPadding: 0,
              isRequired: false,
              textInputType: TextInputType.emailAddress,
              name: widget.formEmailLoginName,
              hintText: 'loginVerify.username'.tr(),
              maxLength: 45,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ],
            ),
          ),
          kVerticalSpacer,
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppInputPassword(
              name: widget.formPasswordLoginName,
              hintText: 'password'.tr(),
              validators: [FormBuilderValidators.required()],
              isDarkBackground: false,
            ),
          ),
          kVerticalSpacerMini,
          TextButton(
              onPressed: () {
                context.router.push(const ForgetPasswordRoute());
              },
              child: Text(
                'forgottenYourPassword'.tr(),
                style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
              )),
          kVerticalSpacerMini,
          if(isLoading == true && widget.fromPopUp) ... [

            AppLoading(),
          ] else ... [
            ElevatedButton(
              onPressed: () => onLogin(context,widget.fromPopUp),
              child:  Text(
                'loginVerify.logIn'.tr(),


                style: kLargeHeavy,
              ),
            ),
            kVerticalSpacer,
            OutlinedButton(
              onPressed: () => context.router.push(
                const SignupWrapperRoute(),
              ), //kMedium15Heavy
              child:
              Text('createAccount'.tr(),
                style: kLargeHeavy,
              ),

            ),

          ],

        ],
      ),
    );
  }
}
