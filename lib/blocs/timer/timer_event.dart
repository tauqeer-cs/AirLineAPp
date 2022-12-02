part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});

  final int duration;

  @override
  List<Object> get props => [duration];
}

class TimerReset extends TimerEvent {
  const TimerReset();

  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({
    required this.duration,
    required this.expiredTime,
  });

  final int duration;
  final DateTime expiredTime;

  @override
  // TODO: implement props
  List<Object?> get props => [duration];
}
