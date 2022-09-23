import 'package:app/app/app_router.dart';
import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
final appRouter = AppRouter();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp.router(
          routerDelegate: appRouter.delegate(),
          // localizationsDelegates: const [],
          // supportedLocales: const [],
          routeInformationParser: appRouter.defaultRouteParser(),
          theme: Styles.theme(true),
          darkTheme: Styles.theme(false),
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}
