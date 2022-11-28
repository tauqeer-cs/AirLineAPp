import 'dart:async';

import 'package:app/blocs/timer/ticker_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TickerRepository _tickerRepository;
  static const int _duration = 0;
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
    _tickerSubscription?.cancel();
    _tickerSubscription = _tickerRepository
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    print("timer duration is ${state.durationRemaining}");
    emit(TimerState(durationRemaining: event.duration));
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
