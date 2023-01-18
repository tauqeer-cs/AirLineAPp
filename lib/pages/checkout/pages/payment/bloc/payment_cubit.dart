import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_flavor.dart';
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
  PaymentCubit() : super(const PaymentState());
  final _repository = FlightRepository();


  updateSuperPnr(String newSuperPnr){
    if(state.paymentResponse!=null){
      final newPaymentResponse = state.paymentResponse!.copyWith(superPnrNo: newSuperPnr);
      emit(state.copyWith(paymentResponse: newPaymentResponse));
    }
  }

  pay({
    String? voucherCode,
    String? promoCode,
    FlightSummaryPnrRequest? flightSummaryPnrRequest,
    String? token,
    num? total,
    num? totalNeedPaid,
    String? redeemCodeToSend,
  }) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final paymentDetail = PaymentDetail(
        promoCode: promoCode,
        totalAmount: total,
        totalAmountNeedToPay: totalNeedPaid,
        frontendUrl: AppFlavor.paymentRedirectUrl,
        myRewardRedemptionName: redeemCodeToSend
      );
      FlightSummaryPnrRequest? flightSummaryPnrRequestNew;
      if((promoCode?.isNotEmpty ?? false) && flightSummaryPnrRequest!=null){
         flightSummaryPnrRequestNew = flightSummaryPnrRequest.copyWith(
          promoCode: promoCode
        );
      }else{
        flightSummaryPnrRequestNew = flightSummaryPnrRequest;
      }
      final bookRequest = state.paymentResponse != null
          ? BookRequest(
              paymentDetail: paymentDetail,
              superPNRNo: state.paymentResponse?.superPnrNo,
            )
          : BookRequest(
              token: token,
              paymentDetail: paymentDetail,
              flightSummaryPNRRequest: flightSummaryPnrRequestNew,
            );
      final payRedirection = await _repository.bookFlight(bookRequest);
      if(payRedirection.value?.paymentRedirectData?.isAlreadySuccessPayment ?? false){

      }
      FormData formData = FormData.fromMap(
          payRedirection.value?.paymentRedirectData?.redirectMap() ?? {});
      var response = await Dio().post(
        payRedirection.value?.paymentRedirectData?.paymentUrl ?? "",
        data: formData,
      );

      emit(state.copyWith(
        blocState: BlocState.finished,
        bookRequest: bookRequest,
        paymentResponse: payRedirection.value,
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
