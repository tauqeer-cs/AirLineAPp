import 'package:app/blocs/timer/timer_bloc.dart';
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
    super.onEvent(bloc, event);
    if (bloc is TimerBloc) return;
    logger.d('onEvent(${bloc.runtimeType}, $event)');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is TimerBloc) return;
    logger.d('onChange(${bloc.runtimeType}, $change)');
  }
}
