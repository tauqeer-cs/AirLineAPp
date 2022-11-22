part of 'timer_bloc.dart';

class TimerState extends Equatable {
  final int durationRemaining;

  const TimerState({
    this.durationRemaining = 0,
  });

  @override
  List<Object?> get props => [durationRemaining];

  TimerState copyWith({int? durationRemaining}) {
    return TimerState(
      durationRemaining: durationRemaining ?? this.durationRemaining,
    );
  }
}
