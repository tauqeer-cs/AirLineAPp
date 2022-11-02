part of 'voucher_cubit.dart';



class VoucherState extends Equatable {
  final VoucherResponse? response;
  final BlocState blocState;
  final String message;
  final String? appliedVoucher;

  const VoucherState({
    this.response,
    this.blocState = BlocState.initial,
    this.message = '',
    this.appliedVoucher = '',
  });

  VoucherState copyWith({
    BlocState? blocState,
    String? message,
    VoucherResponse? response,
    String? appliedVoucher,
  }) {
    return VoucherState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      response: response ?? this.response,
      appliedVoucher: appliedVoucher ?? this.appliedVoucher,

    );
  }

  @override
  List<Object?> get props => [response, blocState, message, appliedVoucher];
}

