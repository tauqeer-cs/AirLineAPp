part of 'voucher_cubit.dart';

class VoucherState extends Equatable {
  final VoucherResponse? response;
  final BlocState blocState;
  final String message;
  final String? appliedVoucher;
  final bool promoLoaded;
  late String? flightToken;

  final AvailableRedeemOptions? selectedRedeemOption;

  RedemptionOption? redemptionOption;

  VoucherState({
    this.response,
    this.blocState = BlocState.initial,
    this.message = '',
    this.appliedVoucher = '',
    this.redemptionOption,
    this.promoLoaded = false,
    this.selectedRedeemOption,
    this.flightToken,
  });

  VoucherState copyWith(
      {BlocState? blocState,
      String? message,
      VoucherResponse? response,
      String? appliedVoucher,
      bool? promoReady,
      AvailableRedeemOptions? selectedRedeemOption,
      RedemptionOption? redemptionOption,
      String? flightToken}) {
    return VoucherState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      response: response ?? this.response,
      appliedVoucher: appliedVoucher ?? this.appliedVoucher,
      promoLoaded: promoReady ?? promoLoaded,
      selectedRedeemOption: selectedRedeemOption ?? this.selectedRedeemOption,
      redemptionOption: redemptionOption ?? this.redemptionOption,
      flightToken: flightToken ?? this.flightToken,
    );
  }

  @override
  List<Object?> get props => [
        response,
        blocState,
        message,
        appliedVoucher,
        redemptionOption,
        selectedRedeemOption,
        promoLoaded,
        flightToken,
      ];
}
