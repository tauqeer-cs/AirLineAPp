import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/forget_password/bloc/forget_password_cubit.dart';
import 'package:app/pages/forget_password/ui/enter_email_form.dart';
import 'package:app/pages/forget_password/ui/success_dialog.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/wave_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool showSuccessScreen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const AppLoadingScreen(),
        child: BlocProvider(
          create: (context) => ForgetPasswordCubit(),
          child: BlocListener<ForgetPasswordCubit, GenericState>(
            listener: (context, state) {
              blocListenerWrapper(
                blocState: state.blocState,
                onLoading: () => context.loaderOverlay.show(),
                onFailed: () {
                  context.loaderOverlay.hide();
                  Toast.of(context).show(message: state.message);
                },
                onFinished: () {
                  context.loaderOverlay.hide();
                  setState(() {
                    showSuccessScreen = true;
                  });
                },
              );
            },
            child: WaveBackground(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  leading: const BackButton(
                    color: Colors.white,
                  ),
                  title: Text(
                    '${'paymentView.reset'.tr()} ${'personalInfo.password'.tr()}',
                    style: kHugeSemiBold.copyWith(color: Colors.white),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: showSuccessScreen ? const SuccessDialog() :  EnterEmailForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
