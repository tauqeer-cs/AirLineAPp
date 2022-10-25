import 'package:app/app/app_router.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
  }

  initDynamicLink(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      navigatorObservers: () => [MyObserver()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(MyFlutterApp.icohome),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: const Icon(MyFlutterApp.ico_deals),
              label: "Deals",
            ),
            BottomNavigationBarItem(
              icon: const Icon(MyFlutterApp.icomybooking),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: const Icon(MyFlutterApp.icocheckin),
              label: "Check-In",
            ),
            BottomNavigationBarItem(
              icon: const Icon(MyFlutterApp.icologinactive),
              label: "Login",
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

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {}

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    //Analytics.firebaseAnalytics.setCurrentScreen(screenName: route.name);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    //Analytics.firebaseAnalytics.setCurrentScreen(screenName: route.name);
  }
}
