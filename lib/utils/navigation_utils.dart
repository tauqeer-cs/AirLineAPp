import 'package:app/app.dart';
import 'package:app/app/app_router.dart';
import 'package:auto_route/auto_route.dart';

class NavigationUtils {
  /// 5 possible route
  /// 1. "home" = search flight page
  /// 2. "deals" = deals page
  /// 3. "bookings" = bookings page
  /// 4. "check-in" = check-in page
  /// 5. "auth" = login/profile page
  static navigateMainPage(String route) {
    final currentContext = appRouter.navigatorKey.currentContext;
    if (currentContext == null) return;
    print("current is ${currentContext.router.current.name}");
    if(currentContext.router.current.name == NavigationRoute.name){
      int index = 0;
      print("route is $route ${route == "deals"}");
      if (route == "deals") index = 1;
      if (route == "bookings") index = 2;
      if (route == "check-in") index = 3;
      if (route == "auth") index = 4;
      print("index is $index");
      currentContext.innerRouterOf<TabsRouter>(NavigationRoute.name)?.setActiveIndex(index);
    }
  }
}
