import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/book_request.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/pay_redirection.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
        frontendUrl: AppFlavor.paymentRedirectUrl,
      );
      final bookRequest = state.paymentResponse != null
          ? BookRequest(
              paymentDetail: paymentDetail,
              superPNRNo: state.paymentResponse?.superPnrNo,
            )
          : BookRequest(
              token: token,
              paymentDetail: paymentDetail,
              flightSummaryPNRRequest: flightSummaryPnrRequest,
            );
      final redirectionData = await _repository.bookFlight(bookRequest);
      FormData formData = FormData.fromMap(
          redirectionData.paymentRedirectData?.redirectMap() ?? {});
      print(
          "payment url is ${redirectionData.paymentRedirectData?.paymentUrl}");
      var response = await Dio().post(
        redirectionData.paymentRedirectData?.paymentUrl ?? "",
        data: formData,
      );
      print("response from payment ${response.data}");

      emit(state.copyWith(
        blocState: BlocState.finished,
        bookRequest: bookRequest,
        paymentResponse: redirectionData,
        paymentRedirect: response.data,
      ));
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
