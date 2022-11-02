part of 'voucher_cubit.dart';



class VoucherState extends Equatable {
  final dynamic response;
  final BlocState blocState;
  final String message;

  const VoucherState({
    this.response,
    this.blocState = BlocState.initial,
    this.message = '',
  });

  VoucherState copyWith({
    BlocState? blocState,
    String? message,
    dynamic response,
  }) {
    return VoucherState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [response, blocState, message];
}

