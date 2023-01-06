part of 'summary_cubit.dart';

class SummaryState extends Equatable {
  final SummaryResponse? summaryResponse;
  final SummaryRequest? summaryRequest;
  final BlocState blocState;
  final String message;
  final bool promoLoaded;
  late AvailableRedeemOptions? selectedRedeemOption;

  RedemptionOption? lmsRedemptionOption;

  SummaryState({
    this.summaryResponse,
    this.summaryRequest,
    this.blocState = BlocState.initial,
    this.message = '',
    this.lmsRedemptionOption,
    this.promoLoaded = false,
    this.selectedRedeemOption,
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
      lmsRedemptionOption: redemptionOption ?? lmsRedemptionOption,
      promoLoaded: promoReady ?? promoLoaded,
      selectedRedeemOption: selectedRedeemOption ?? this.selectedRedeemOption,
    );
  }

  @override
  List<Object?> get props => [
        summaryResponse,
        blocState,
        message,
        summaryRequest,
        lmsRedemptionOption,
        selectedRedeemOption
      ];
}
