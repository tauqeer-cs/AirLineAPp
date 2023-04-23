import 'package:app/app/app_router.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/styles.dart';
import 'package:app/utils/error_utils.dart';
import 'package:app/utils/widget_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/remote_config_repository.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    initDialogSystem();
  }

  initDialogSystem() async {
    try {
      await RemoteConfigRepository.versionChecking();
      if (mounted) {
        WidgetUtils.appUpdateDialog(context);
      }
    } catch (e, st) {
      ErrorUtils.getErrorMessage(e, st);
    }
  }

  initDynamicLink(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    final isLogin =
        context.watch<AuthBloc>().state.status == AppStatus.authenticated;
    return AutoTabsScaffold(
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(MyFlutterApp.icohome),
              label: 'home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(MyFlutterApp.ico_deals),
              label: 'navBar.deals'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/design/icoMybooking.png",
                height: 30,
                color:
                    tabsRouter.activeIndex == 2 ? Styles.kPrimaryColor : null,
              ),
              label: 'navBar.bookings'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/design/icoCheckin.png",
                color:
                    tabsRouter.activeIndex == 3 ? Styles.kPrimaryColor : null,
                height: 30,
              ),
              label: 'navBar.checkin'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/design/icoAccount.png",
                color:
                    tabsRouter.activeIndex == 4 ? Styles.kPrimaryColor : null,
                height: 30,
              ),
              label:
                  isLogin ? 'navBar.account'.tr() : 'navBar.signupLogIn'.tr(),
            ),
          ],
        );
      },
      routes: const [
        HomeRoute(),
        DealsRoute(),
        BookingsRoute(),
        CheckInRoute(),
        AuthRoute(),
      ],
    );
  }
}
