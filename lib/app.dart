import 'dart:developer';

import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/airports/airports_cubit.dart';
import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/booking_local/booking_local_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/countries/countries_cubit.dart';
import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/blocs/routes/routes_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/timer/ticker_repository.dart';
import 'package:app/blocs/timer/timer_bloc.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/containers/version_banner_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'widgets/dialogs/app_confirmation_dialog.dart';

final appRouter = AppRouter();
final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if(state == AppLifecycleState.resumed){
      final timerRemaining = context.read<TimerBloc>().state.durationRemaining;
      showExpiredSession(timerRemaining);
    }
  }

  showExpiredSession(int durationRemaining){
    print("duration remaining ${durationRemaining}");
    final currentContext = appRouter.navigatorKey.currentContext;
    if (currentContext == null) {
      FirebaseCrashlytics.instance.recordError(
        "Current context for timer is null",
        StackTrace.current,
      );
      return;
    }
    if (durationRemaining == 600) {
      FirebaseAnalytics.instance.logEvent(name: "session_prompt_dialog");
      print("duration remaining ${durationRemaining}");
      showDialog(
        context: currentContext,
        barrierDismissible: false,
        builder: (context) {
          return AppConfirmationDialog(
            title: "Your session is about to expire in 10 minutes.",
            subtitle: "",
            confirmText: "Stay and Continue",
            onConfirm: () {
              final filterState = currentContext
                  .read<SearchFlightCubit>()
                  .state
                  .filterState;
              currentContext
                  .read<BookingCubit>()
                  .reVerifyFlight(filterState);
            },
          );
        },
      );
    } else if (durationRemaining == 0) {
      FirebaseAnalytics.instance.logEvent(name: "session_expired_dialog");
      showDialog(
        context: currentContext,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AppConfirmationDialog(
              showCloseButton: false,
              title:
              "Your session is expired, please retry your search!",
              subtitle: "",
              onConfirm: () {
                currentContext.router.pop();
                appRouter.replaceAll([const NavigationRoute()]);
                currentContext.read<TimerBloc>().add(TimerReset());
              },
              confirmText: "Okay",
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountriesCubit()..getCountries()),
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => SearchFlightCubit()),
        BlocProvider(create: (_) => BookingCubit()),
        BlocProvider(
          create: (_) => TimerBloc(
            tickerRepository: const TickerRepository(),
          ),
        ),
        BlocProvider(create: (_) => SelectedPersonCubit()),
        BlocProvider(create: (context) => VoucherCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => CmsSsrCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => SummaryContainerCubit()),
        BlocProvider(
            create: (_) =>
                AuthBloc(authenticationRepository: AuthenticationRepository())),
        BlocProvider(create: (_) => RoutesCubit()..getRoutes(), lazy: false),
        BlocProvider(
            create: (_) => LocalUserBloc()..add(const Init()), lazy: false),
        BlocProvider(create: (_) => BookingLocalCubit()..getBooking()),
        BlocProvider(
          create: (_) => AirportsCubit()..getAirports(),
          lazy: false,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AppStatus.authenticated) {
                context.read<ProfileCubit>().getProfile();
              }
            },
          ),
          BlocListener<BookingCubit, BookingState>(
            listenWhen: (prev, curr) => !prev.isVerify && curr.isVerify,
            listener: (context, state) {
              log("current bloc state is ${state.verifyResponse}");
              final expiredInUTC = state.verifyResponse?.verifyExpiredDateTime;
              if (expiredInUTC == null) return;
              final nowUTC = DateTime.now().toUtc();
              final diff = expiredInUTC.difference(nowUTC);
              print("durations is $diff");
              context
                  .read<TimerBloc>()
                  .add(TimerStarted(duration: diff.inSeconds));
            },
          ),
          BlocListener<TimerBloc, TimerState>(
            listener: (context, state) {
              showExpiredSession(state.durationRemaining);
            },
          ),
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
              context.read<VoucherCubit>().resetState();
              context.read<TimerBloc>().add(const TimerReset());
              context
                  .read<SelectedPersonCubit>()
                  .selectPerson(state.filterState?.numberPerson.persons.first);
            },
          ),
        ],
        child: VersionBannerWidget(
          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, __) {
              return MaterialApp.router(
                routerDelegate: appRouter.delegate(),
                localizationsDelegates: const [
                  FormBuilderLocalizations.delegate,
                ],
                builder: (context, child) {
                  final mediaQueryData = MediaQuery.of(context);
                  final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.1);
                  return MediaQuery(
                    data:
                        MediaQuery.of(context).copyWith(textScaleFactor: scale),
                    child: child!,
                  );
                },
                debugShowCheckedModeBanner: false,
                routeInformationParser: appRouter.defaultRouteParser(),
                theme: Styles.theme(true),
                darkTheme: Styles.theme(false),
                themeMode: ThemeMode.light,
              );
            },
          ),
        ),
      ),
    );
  }
}
