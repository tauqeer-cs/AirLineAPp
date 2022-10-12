part of 'payment_cubit.dart';


class PaymentState extends Equatable {
  final dynamic paymentResponse;
  final BookRequest? bookRequest;
  final BlocState blocState;
  final String message;

  const PaymentState({
    this.paymentResponse,
    this.bookRequest,
    this.blocState = BlocState.initial,
    this.message = '',
  });
  PaymentState copyWith({
    BlocState? blocState,
    String? message,
    dynamic paymentResponse,
    BookRequest? bookRequest,
  }) {
    return PaymentState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      paymentResponse: paymentResponse ?? this.paymentResponse,
      bookRequest: bookRequest ?? this.bookRequest,
    );
  }
  @override
  List<Object?> get props => [paymentResponse, blocState, message, bookRequest];
}

