import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/pages/account_setting/bloc/update_password_cubit.dart';
import 'package:app/pages/communication_settings/ui/settings_view.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CommunicationSettingPage extends StatelessWidget {
  const CommunicationSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const AppLoadingScreen(message: 'Updating'),
        child: BlocListener<ProfileCubit, ProfileState>(
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
                context.router.pop();
                Toast.of(context)
                    .show(message: "Preferences Updated", success: true);
              },
            );
          },
          child: Scaffold(
            appBar: AppAppBar(
              centerTitle: true,
              title: 'Account Settings',
              height: 80.h,
              overrideInnerHeight: true,
              child: Column(
                children: [
                  Text(
                    'Communication\nPreferences',
                    style: kHugeSemiBold.copyWith(
                      color: Styles.kDartTeal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            body: Container(
              color: Colors.white,
              child: const SettingsView(),
            ),
          ),
        ),
      ),
    );
  }
}
