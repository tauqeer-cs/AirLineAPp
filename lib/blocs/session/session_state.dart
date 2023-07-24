part of 'session_bloc.dart';

class SessionState extends Equatable {
  final int durationRemaining;

  const SessionState({
    this.durationRemaining = 600,
  });

  @override
  List<Object?> get props => [durationRemaining];

  SessionState copyWith({int? durationRemaining}) {
    return SessionState(
      durationRemaining: durationRemaining ?? this.durationRemaining,
    );
  }
}
