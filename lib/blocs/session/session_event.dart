part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
}

class SessionTicked extends SessionEvent {
  const SessionTicked({required this.duration});

  final int duration;

  @override
  List<Object> get props => [duration];
}

class SessionReset extends SessionEvent {
  const SessionReset();

  @override
  List<Object?> get props => [];
}

class SessionStarted extends SessionEvent {
  const SessionStarted({
    required this.duration,
    required this.expiredTime,
  });

  final int duration;
  final DateTime expiredTime;

  @override
  // TODO: implement props
  List<Object?> get props => [duration];
}
