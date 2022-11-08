import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/pages/auth/ui/auth_view.dart';
import 'package:app/pages/auth/ui/profile_view.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/wrapper/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const AppLoadingScreen(message: "Loading"),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            blocListenerWrapper(
              blocState: state.blocState,
              onLoading: () => context.loaderOverlay.show(),
              onFailed: () {
                context.loaderOverlay.hide();
                Toast.of(context).show(message: state.message);
              },
              onFinished: () => context.loaderOverlay.hide(),
            );
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/images/design/home_bg.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const Scaffold(
                backgroundColor: Colors.transparent,
                body: AuthWrapper(
                  authChild: ProfileView(),
                  child: AuthView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
