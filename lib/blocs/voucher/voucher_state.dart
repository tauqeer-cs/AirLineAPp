part of 'voucher_cubit.dart';

class VoucherState extends Equatable {
  final VoucherResponse? response;
  final BlocState blocState;
  final String message;
  final String? appliedVoucher;
  final bool promoLoaded;
  late String? flightToken;

  final bool redeemingPromo;

  final bool pointsRedeemed;

  final AvailableRedeemOptions? selectedRedeemOption;

  RedemptionOption? redemptionOption;

  VoucherState( {
    this.response,
    this.blocState = BlocState.initial,
    this.message = '',
    this.appliedVoucher = '',
    this.redemptionOption,
    this.promoLoaded = false,
    this.selectedRedeemOption,
    this.flightToken,
    this.redeemingPromo = false,
    this.pointsRedeemed = false,
  });

  VoucherState copyWith({
    BlocState? blocState,
    String? message,
    VoucherResponse? response,
    String? appliedVoucher,
    bool? promoReady,
    AvailableRedeemOptions? selectedRedeemOption,
    RedemptionOption? redemptionOption,
    String? flightToken,
    bool? redeemingPromo,
    bool? pointsRedeemed,

  }) {
    return VoucherState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      response: response ?? this.response,
      appliedVoucher: appliedVoucher ?? this.appliedVoucher,
      promoLoaded: promoReady ?? promoLoaded,
      selectedRedeemOption: selectedRedeemOption ?? this.selectedRedeemOption,
      redemptionOption: redemptionOption ?? this.redemptionOption,
      flightToken: flightToken ?? this.flightToken,
      redeemingPromo: redeemingPromo ?? this.redeemingPromo,
      pointsRedeemed: pointsRedeemed ?? this.pointsRedeemed,
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
        redeemingPromo,
    pointsRedeemed,
      ];
}
