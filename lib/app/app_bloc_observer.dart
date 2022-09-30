import 'package:bloc/bloc.dart';

import 'app_logger.dart';

/// To watch and debug bloc state
class AppBlocObserver extends BlocObserver {
  /*@override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d('onTransition(${bloc.runtimeType}, $transition)');
  }*/

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('onError(${bloc.runtimeType}, $error, $stackTrace)');
    /*FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: 'error in bloc ${bloc.state}'
    );*/
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.d('onEvent(${bloc.runtimeType}, $event)');

    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d('onChange(${bloc.runtimeType}, $change)');
  }
}
