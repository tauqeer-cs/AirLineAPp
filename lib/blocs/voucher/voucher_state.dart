part of 'voucher_cubit.dart';

class VoucherState extends Equatable {
  final VoucherResponse? response;
  final BlocState blocState;
  final bool dontShowVoucher;

  final String? lastText;

  final String message;
  final String? appliedVoucher;
  final bool promoLoaded;
  late String? flightToken;
  final AvailableRedeemOptions? selectedRedeemOption;
  final InsertVoucherPIN? insertedVoucher;
  RedemptionOption? redemptionOption;

  VoucherState( {
    this.response,
    this.dontShowVoucher = false,
    this.blocState = BlocState.initial,
    this.message = '',
    this.lastText,
    this.appliedVoucher = '',
    this.redemptionOption,
    this.promoLoaded = false,
    this.selectedRedeemOption,
    this.flightToken,
    this.insertedVoucher,
  });

  VoucherState copyWith({
    BlocState? blocState,
    String? message,
    VoucherResponse? Function()? response,
    String? Function()? appliedVoucher,
    bool? promoReady,
    AvailableRedeemOptions? selectedRedeemOption,
    RedemptionOption? redemptionOption,
    String? flightToken,
    bool? redeemingPromo,
    bool? pointsRedeemed,
    InsertVoucherPIN? Function()? insertedVoucher,
    bool? dontShowVoucher,
    String? lastText,
  }) {
    return VoucherState(
      dontShowVoucher: dontShowVoucher ?? this.dontShowVoucher,
      lastText: lastText ?? this.lastText,
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      response: response != null ? response() : this.response,
      insertedVoucher: insertedVoucher != null ? insertedVoucher() : this.insertedVoucher,
      appliedVoucher: appliedVoucher != null ? appliedVoucher() : this.appliedVoucher,
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
    dontShowVoucher,
    lastText
      ];
}
