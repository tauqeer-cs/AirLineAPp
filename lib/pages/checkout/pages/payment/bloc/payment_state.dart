part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final PayRedirection? paymentResponse;
  final BookRequest? bookRequest;
  final BlocState blocState;
  final String message;
  final String? paymentRedirect;

  const PaymentState({
    this.paymentResponse,
    this.bookRequest,
    this.blocState = BlocState.initial,
    this.message = '',
    this.paymentRedirect,
  });

  PaymentState copyWith({
    BlocState? blocState,
    String? message,
    PayRedirection? paymentResponse,
    BookRequest? bookRequest,
    String? paymentRedirect,
  }) {
    return PaymentState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      paymentResponse: paymentResponse ?? this.paymentResponse,
      bookRequest: bookRequest ?? this.bookRequest,
      paymentRedirect: paymentRedirect ?? this.paymentRedirect,
    );
  }

  @override
  List<Object?> get props =>
      [paymentResponse, blocState, message, bookRequest, paymentRedirect];
}
