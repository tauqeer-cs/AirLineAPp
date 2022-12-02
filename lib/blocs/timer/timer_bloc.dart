import 'dart:async';

import 'package:app/blocs/timer/ticker_repository.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TickerRepository _tickerRepository;
  final LocalRepository _localRepository = LocalRepository();

  static const int _duration = 999999;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required TickerRepository tickerRepository})
      : _tickerRepository = tickerRepository,
        super(const TimerState()) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerReset>(_onReset);
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerState(durationRemaining: event.duration));
    _localRepository.storeExpiredTime(event.expiredTime.toIso8601String());
    _tickerSubscription?.cancel();
    _tickerSubscription = _tickerRepository
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerState(durationRemaining: event.duration < 0 ? 0 :event.duration));
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerState(durationRemaining: _duration));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
