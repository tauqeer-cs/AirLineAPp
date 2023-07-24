import 'dart:async';

import 'package:app/blocs/session/ticker_repository.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final TickerSessionRepository _tickerRepository;
  final LocalRepository _localRepository = LocalRepository();

  static const int _duration = 600;
  StreamSubscription<int>? _tickerSubscription;

  SessionBloc({required TickerSessionRepository tickerRepository})
      : _tickerRepository = tickerRepository,
        super(const SessionState()) {
    on<SessionStarted>(_onStarted);
    on<SessionTicked>(_onTicked);
    on<SessionReset>(_onReset);
  }

  void _onStarted(SessionStarted event, Emitter<SessionState> emit) {
    emit(SessionState(durationRemaining: event.duration));
    _localRepository.storeSessionExpiredTime(event.expiredTime.toIso8601String());
    _tickerSubscription?.cancel();
    _tickerSubscription = _tickerRepository
        .tick(ticks: event.duration)
        .listen((duration) => add(SessionTicked(duration: duration)));
  }

  void _onTicked(SessionTicked event, Emitter<SessionState> emit) {
    emit(SessionState(durationRemaining: event.duration < 0 ? 0 :event.duration));
  }

  void _onReset(SessionReset event, Emitter<SessionState> emit) {
    _tickerSubscription?.cancel();
    emit(const SessionState(durationRemaining: _duration));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
