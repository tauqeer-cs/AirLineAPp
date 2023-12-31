import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/validate_email/validate_email_cubit.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:loader_overlay/loader_overlay.dart';

const formNameFirstName = "_first_name";
const formNameLastName = "_last_name";
const formNameTitle = "_title";
const formNameNationality = "_nationality";
const formNameDob = "_dob";
const formNameEmail = "contact_email";
const formNamePhone = "phone";
const formNamePhoneCode = "phone_code";
const formNamePassword = "password";
const formNameConfirmPassword = "confirm_password";
const formNameNewPassword = "new_password";

const formNameGender = "gender";
const formNameAddress = "address";
const formNameCountry = "country";
const formNameState = "state";
const formNameCity = "city";
const formNamePostCode = "postCode";
const formNameMyKad = "myKadNo";
const formNameAddressEmail = "contact_address_email";

const formNameFirstNameEmergency = "emergency_first_name";
const formNameLastNameEmergency = "emergency_last_name";
const formNameRelationshipEmergency = "emergency_relationship";
const formNamePhoneRelationship = "emergency_phone";
const formNamePhoneCodeRelationship = "emergency_phone_code";
const formNamePhoneNoRelationship = "emergency_phone_no";

class SignupWrapperPage extends StatelessWidget {
  const SignupWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: LoaderOverlay(
        overlayWidget: AppLoadingScreen(message: "loading".tr()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SignupCubit(),
            ),
            BlocProvider(
              create: (context) => ValidateEmailCubit(),
            ),
          ],
          child: BlocListener<SignupCubit, SignupState>(
            listener: (context, state) {
              blocListenerWrapper(
                blocState: state.blocState,
                onLoading: () => context.loaderOverlay.show(),
                onFailed: () {
                  context.loaderOverlay.hide();
                  Toast.of(context).show(message: state.message);
                },
                onFinished: () {
                  FlutterInsider.Instance.signUpConfirmation();
                  UserInsider.of(context).registerStandardEvent(
                      InsiderConstants.registrationCompleted);

                  context.loaderOverlay.hide();
                  context.router.root.replace(
                      CompleteSignupRoute(signupRequest: state.signupRequest));
                  Toast.of(context)
                      .show(message: "Account created", success: true);
                },
              );
            },
            child: const AutoRouter(),
          ),
        ),
      ),
    );
  }
}
