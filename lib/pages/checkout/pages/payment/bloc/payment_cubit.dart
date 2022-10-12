import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/book_request.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentState());
  final _repository = FlightRepository();

  pay({
    String? voucherCode,
    String? promoCode,
    FlightSummaryPnrRequest? flightSummaryPnrRequest,
    String? token,
    num? total,
    num? totalNeedPaid,
  }) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final paymentDetail = PaymentDetail(
        promoCode: promoCode,
        totalAmount: total,
        totalAmountNeedToPay: totalNeedPaid,
      );
      final bookRequest = BookRequest(
        token: token,
        paymentDetail: paymentDetail,
        flightSummaryPNRRequest: flightSummaryPnrRequest,
      );
      final response = await _repository.bookFlight(bookRequest);
      emit(state.copyWith(
          blocState: BlocState.finished,
          bookRequest: bookRequest,
          paymentResponse: response));
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
    }
  }
}
