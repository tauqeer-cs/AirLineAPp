import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/airports/airports_cubit.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/booking_local/booking_local_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/countries/countries_cubit.dart';
import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/blocs/routes/routes_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/theme/styles.dart';
import 'package:app/utils/fcm_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
        BlocProvider(create: (_) => CountriesCubit()..getCountries()),
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => SearchFlightCubit()),
        BlocProvider(create: (_) => BookingCubit()),
        BlocProvider(create: (_) => SelectedPersonCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => CmsSsrCubit()),
        BlocProvider(create: (_) => AuthBloc(authenticationRepository: AuthenticationRepository())),
        BlocProvider(create: (_) => RoutesCubit()..getRoutes(), lazy: false),
        BlocProvider(create: (_) => LocalUserBloc()..add(const Init()), lazy: false),
        BlocProvider(create: (_) => BookingLocalCubit()..getBooking()),
        BlocProvider(
          create: (_) => AirportsCubit()..getAirports(),
          lazy: false,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RoutesCubit, RoutesState>(
            listener: (context, state) {
              context.read<HomeCubit>().getContents(state.routes);
              context.read<CmsSsrCubit>().getCmsSSR(state.routes);
            },
          ),
          BlocListener<SearchFlightCubit, SearchFlightState>(
            listenWhen: (previous, current) =>
                previous.blocState != BlocState.finished &&
                current.blocState == BlocState.finished,
            listener: (context, state) {
              context.read<BookingCubit>().resetState();
              context
                  .read<SelectedPersonCubit>()
                  .selectPerson(state.filterState?.numberPerson.persons.first);
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
              localizationsDelegates: const [
                FormBuilderLocalizations.delegate,
              ],
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
