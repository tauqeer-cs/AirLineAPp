part of 'summary_cubit.dart';

class SummaryState extends Equatable {
  final SummaryResponse? summaryResponse;
  final SummaryRequest? summaryRequest;
  final BlocState blocState;
  final String message;

  const SummaryState({
    this.summaryResponse,
    this.summaryRequest,
    this.blocState = BlocState.initial,
    this.message = '',
  });

  SummaryState copyWith(
      {BlocState? blocState,
      String? message,
      SummaryResponse? summaryResponse,
      SummaryRequest? summaryRequest,
      RedemptionOption? redemptionOption,
      bool? promoReady,
      AvailableRedeemOptions? selectedRedeemOption}) {
    return SummaryState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      summaryResponse: summaryResponse ?? this.summaryResponse,
      summaryRequest: summaryRequest ?? this.summaryRequest,
    );
  }

  @override
  List<Object?> get props => [
        summaryResponse,
        blocState,
        message,
        summaryRequest,
      ];
}
