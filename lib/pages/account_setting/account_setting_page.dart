import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/account_setting/bloc/update_password_cubit.dart';
import 'package:app/pages/account_setting/ui/account_setting_view.dart';
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

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const AppLoadingScreen(message: 'Updating Password'),
        child: BlocListener<UpdatePasswordCubit, GenericState>(
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
                Toast.of(context).show(message: "Password Updated", success: true);
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
                    'Account Settings',
                    style: kHugeSemiBold.copyWith(color: Styles.kDartTeal),
                  ),
                ],
              ),
            ),
            body: Container(
              color: Colors.white,
              child: AccountSettingView(),
            ),
          ),
        ),
      ),
    );
  }
}
