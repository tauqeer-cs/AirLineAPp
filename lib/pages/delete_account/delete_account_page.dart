import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/pages/delete_account/bloc/delete_account_cubit.dart';
import 'package:app/pages/delete_account/ui/delete_account_form.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/wave_background.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const AppLoadingScreen(),
      child: BlocProvider(
        create: (context) => DeleteAccountCubit(),
        child: BlocListener<DeleteAccountCubit, GenericState>(
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
                context.router.replaceAll([
                  const NavigationRoute(),
                ]);
                Toast.of(context).show(message: "Account Deleted");
                AuthenticationRepository().logout();
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
                  'closeAccount'.tr(),
                  style: kHugeSemiBold.copyWith(color: Colors.white),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: const DeleteAccountForm(),
            ),
          ),
        ),
      ),
    );
  }
}
