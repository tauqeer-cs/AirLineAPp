part of 'summary_cubit.dart';


class SummaryState extends Equatable {
  final SummaryResponse? summaryResponse;
  final BlocState blocState;
  final String message;

  const SummaryState({
    this.summaryResponse,
    this.blocState = BlocState.initial,
    this.message = '',
  });
  SummaryState copyWith({
    BlocState? blocState,
    String? message,
    SummaryResponse? summaryResponse,
  }) {
    return SummaryState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      summaryResponse: summaryResponse ?? this.summaryResponse,
    );
  }
  @override
  List<Object?> get props => [summaryResponse, blocState, message];
}

