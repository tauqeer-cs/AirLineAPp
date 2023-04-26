import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_flavor.dart';
import 'package:app/app/app_logger.dart';
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
import 'package:app/blocs/settings/settings_cubit.dart';
import 'package:app/blocs/timer/ticker_repository.dart';
import 'package:app/blocs/timer/timer_bloc.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/navigation_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/containers/version_banner_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/enum/InsiderCallbackAction.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import 'blocs/manage_booking/manage_booking_cubit.dart';
import 'pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'widgets/dialogs/app_confirmation_dialog.dart';

final appRouter = AppRouter();
final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  List<String> pathWithExpiredSession = [
    BundleRoute().path,
    SeatsRoute().path,
    MealsRoute().path,
    BaggageRoute().path,
    const SelectBundleRoute().path,
    const SelectMealsRoute().path,
    const SelectSeatsRoute().path,
    const SelectBaggageRoute().path,
    const BookingDetailsRoute().path,
    const CheckoutRoute().path,
    const InsuranceRoute().path,
    const PaymentRoute().path,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initInsider();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future initInsider() async {
    print("init insider");
    if (!mounted) return;
    // Call in async method.
    print("init insider 2");

    await FlutterInsider.Instance.init(
      AppFlavor.insiderPartnerName,
      AppFlavor.insiderAppGroup,
      userInsiderCallBack,
    );

    print("init insider 3");

    // This is an utility method, if you want to handle the push permission in iOS own your own you can omit the following method.
    // try {
    //   await FlutterInsider.Instance.visitHomePage();
    // } catch (e) {
    //   logger.e(e);
    //   print("init insider error 5");
    // }
    print("init insider 4");

    print("register with queit");
    FlutterInsider.Instance.registerWithQuietPermission(false);
  }

  userInsiderCallBack(int type, dynamic data) {
    print("user insider callback");
    switch (type) {
      case InsiderCallbackAction.NOTIFICATION_OPEN:
        logger.d("[INSIDER][NOTIFICATION_OPEN]: $data");
        final scheme = data["ins_dl_url_scheme"];
        print("is String ${scheme! is String} ${scheme}");
        if (scheme == null) return;
        NavigationUtils.navigateMainPage(scheme);
        break;
      case InsiderCallbackAction.TEMP_STORE_CUSTOM_ACTION:
        logger.d("[INSIDER][TEMP_STORE_CUSTOM_ACTION]: $data");
        break;
      default:
        logger.d("[INSIDER][InsiderCallbackAction]: Unregistered Action!");
        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      try {
        final currentContext = appRouter.navigatorKey.currentContext;
        final expiredInUTC = LocalRepository().getExpiredTime();
        if (expiredInUTC == null) return;
        final expiredDate = DateTime.parse(expiredInUTC);
        final nowUTC = DateTime.now().toUtc();
        final diff = expiredDate.difference(nowUTC);
        currentContext?.read<TimerBloc>().add(
              TimerStarted(
                duration: diff.inSeconds < 0 ? 1 : diff.inSeconds,
                expiredTime: expiredDate,
              ),
            );
      } catch (e) {
        logger.e("Cannot start timer from resume");
      }
    }
  }

  showExpiredSession(int durationRemaining) {
    final currentContext = appRouter.navigatorKey.currentContext;
    final currentPath = appRouter.currentPath;
    final superPnr = currentContext?.read<BookingCubit>().state.superPnrNo;
    if (!pathWithExpiredSession.contains(currentPath)) {
      return;
    }
    if (currentPath == "/payment" &&
        superPnr != null &&
        currentContext != null) {
      if (durationRemaining == 0) {
        return;
        FirebaseAnalytics.instance.logEvent(name: "session_pnr_dialog");
        showDialog(
          context: currentContext,
          barrierDismissible: false,
          builder: (context) {
            return AppConfirmationDialog(
              showCloseButton: true,
              title: "Your session is about to expire.",
              subtitle: "",
              onConfirm: () {
                currentContext.read<BookingCubit>().reVerifyPNR();
              },
              confirmText: "Stay and Continue",
            );
          },
        );
      }
    } else {
      if (currentContext == null) {
        FirebaseCrashlytics.instance.recordError(
          "Current context for timer is null",
          StackTrace.current,
        );
        return;
      }
      if (durationRemaining == 600) {
        FirebaseAnalytics.instance.logEvent(name: "session_prompt_dialog");
        showDialog(
          context: currentContext,
          barrierDismissible: false,
          builder: (context) {
            return AppConfirmationDialog(
              title: "sessionExpireTen".tr(),
              subtitle: "",
              confirmText: "stayContinue".tr(),
              onConfirm: () {
                final filterState =
                    currentContext.read<SearchFlightCubit>().state.filterState;
                currentContext.read<BookingCubit>().reVerifyFlight(filterState);
              },
            );
          },
        );
      }
      /* else if (durationRemaining == 85) {
        FirebaseAnalytics.instance.logEvent(name: "session_prompt_dialog_five");
        showDialog(
          context: currentContext,
          barrierDismissible: false,
          builder: (context) {
            return AppConfirmationDialog(
              title: "Your session is about to expire in 5 minutes.",
              subtitle: "",
              confirmText: "Stay and Continue",
              onConfirm: () {
                final filterState =
                    currentContext.read<SearchFlightCubit>().state.filterState;
                currentContext.read<BookingCubit>().reVerifyFlight(filterState);
              },
            );
          },
        );
      } */
      else if (durationRemaining == 0) {
        //return;
        FirebaseAnalytics.instance.logEvent(name: "session_expired_dialog");
        showDialog(
          context: currentContext,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => true,
              child: AppConfirmationDialog(
                showCloseButton: false,
                title: "sessionRetrySearch".tr(),
                subtitle: "",
                onConfirm: () {
                  currentContext.router.pop();
                  appRouter.replaceAll([const NavigationRoute()]);
                  currentContext.read<TimerBloc>().add(const TimerReset());
                },
                confirmText: "Okay",
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountriesCubit()..getCountries()),
        BlocProvider(
          create: (_) => SettingsCubit()..getSettings(),
          lazy: false,
        ),
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => SearchFlightCubit()),
        BlocProvider(create: (context) => SummaryCubit()),
        BlocProvider(create: (_) => BookingCubit()),
        BlocProvider(create: (context) => InsuranceCubit()),
        BlocProvider(
          create: (_) => TimerBloc(
            tickerRepository: const TickerRepository(),
          ),
        ),
        BlocProvider(create: (_) => SelectedPersonCubit()),
        BlocProvider(create: (context) => VoucherCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => CmsSsrCubit()),
        BlocProvider(create: (_) => AgentSignUpCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(
          create: (context) => ManageBookingCubit(),
        ),
        BlocProvider(
          create: (_) => SummaryContainerCubit(),
        ),
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
              final expiredInUTC = state.verifyResponse?.verifyExpiredDateTime;
              final currentContext = appRouter.navigatorKey.currentContext;
              if (expiredInUTC == null) return;
              final nowUTC = DateTime.now().toUtc();
              final diff = expiredInUTC.difference(nowUTC);
              context.read<TimerBloc>().add(
                    TimerStarted(
                      duration: state.superPnrNo != null ? 900 : diff.inSeconds,
                      expiredTime: state.superPnrNo != null
                          ? nowUTC.add(const Duration(seconds: 900))
                          : expiredInUTC,
                    ),
                  );
              if (state.blocState == BlocState.failed) {
                if (state.message ==
                    "The outbound seat chosen is not available anymore") {
                  currentContext?.router.replaceAll([const NavigationRoute()]);
                }
              }
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
              context.read<AgentSignUpCubit>().getAgentSignUp(state.routes);
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
        child: Phoenix(
          child: VersionBannerWidget(
            child: ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (_, __) {
                return MaterialApp.router(
                  routerDelegate: appRouter.delegate(
                    navigatorObservers: () => [MyObserver()],
                  ),
                  localizationsDelegates: [
                    FormBuilderLocalizations.delegate,
                    EasyLocalization.of(context)!.delegate,
                  ],
                  supportedLocales: context.supportedLocales,
                  builder: (context, child) {
                    final mediaQueryData = MediaQuery.of(context);
                    final scale =
                        mediaQueryData.textScaleFactor.clamp(1.0, 1.2);
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: scale),
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
      ),
    );
  }
}

class MyObserver extends AutoRouterObserver {
// only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logger.d("init tab ${route.path}");
    checkInsiderEvent(route);
    FirebaseAnalytics.instance.setCurrentScreen(screenName: route.path);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logger.d("change tab ${route.path}");
    checkInsiderEvent(route);
    FirebaseAnalytics.instance.setCurrentScreen(screenName: route.path);
  }

  void checkInsiderEvent(TabPageRoute route) {
    if (route.path == "deals") {
      UserInsider.instance
          .registerStandardEvent(InsiderConstants.dealsPageView);
      UserInsider.instance
          .registerStandardEvent(InsiderConstants.promotionListingPageView);
    }
    if (route.path == "bookings") {
      UserInsider.instance
          .registerStandardEvent(InsiderConstants.manageBookingPageView);
    }
    if (route.path == "check-in") {
      UserInsider.instance
          .registerStandardEvent(InsiderConstants.checkInStarted);
    }
  }

  @override
  void didPush(Route? route, Route? previousRoute) {
    logger.d("push page ${route?.settings.name}");
    if (route != null) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    logger.d("replace page ${newRoute?.settings.name}");
    if (newRoute != null) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    logger.d("pop page ${route.settings.name}");
    if (previousRoute != null) {
      _sendScreenView(previousRoute);
    }
  }

  void _sendScreenView(Route<dynamic> route) {
    String? screenName;
    if (route.settings is AutoRoutePage) {
      screenName = (route.settings as AutoRoutePage).routeData.path;
    } else {
      screenName = route.settings.name;
    }
    if (screenName != null) {
      FirebaseAnalytics.instance
          .setCurrentScreen(screenName: screenName)
          .catchError(
            (Object error) {},
            test: (Object error) => error is PlatformException,
          );
    }
  }
}
