import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/airports/airports_cubit.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/routes/routes_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => SearchFlightCubit()),
        BlocProvider(create: (_) => BookingCubit()),
        BlocProvider(
          create: (_) => AirportsCubit()..getAirports(),
          lazy: false,
        ),
        BlocProvider(create: (_) => RoutesCubit()..getRoutes(), lazy: false),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RoutesCubit, RoutesState>(
            listener: (context, state) {
              final homeId = state.routes.firstWhere(
                  (element) => element.urlSegment?.toLowerCase() == "home");
              context.read<HomeCubit>().getContents(homeId.key ?? "");
            },
          ),
          BlocListener<SearchFlightCubit, SearchFlightState>(
            listenWhen: (previous, current) =>
                current.blocState == BlocState.finished,
            listener: (context, state) {
              context.read<BookingCubit>().resetState();
            },
          ),
        ],
        child: ScreenUtilInit(
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
        ),
      ),
    );
  }
}
