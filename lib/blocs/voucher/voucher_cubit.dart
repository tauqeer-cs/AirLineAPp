import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/data/responses/voucher_response.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/requests/token_request.dart';
import '../../data/responses/promotions_response.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super( VoucherState());
  final _repository = FlightRepository();

  resetState() {
    emit( VoucherState());
  }

  redeemPoints() async {

    final response = await _repository.getRedeemPoints(Token(token: state.flightToken,redemptionName: state.selectedRedeemOption!.redemptionName));
    print('object');

  }
  getAvailablePromotions(String token) async {
    if (state.promoLoaded) {
      return;
    }
     state.flightToken = token;


    final response = await _repository
        .getPromoInfo(Token(token: token));
    print('object');
    if (response.statusCode == 200) {
      emit(state.copyWith(
        blocState: BlocState.finished,
        redemptionOption: response.value!.lmsRedemptionOption,
        promoReady: true,
      ));

      return;
    } else {
      emit(state.copyWith(
        blocState: BlocState.finished,
      //  redemptionOption: response.value!.redemptionOption,
        promoReady: true,
      ));
      return;

    }
  }

  AvailableRedeemOptions? get getSelectedItem {
    return state.selectedRedeemOption;
  }

  selectedItem(AvailableRedeemOptions option) {

    emit(
        state.copyWith(
            selectedRedeemOption: option
        )
    );
  }





  addVoucher(VoucherRequest voucherRequest) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final response = await _repository.addVoucher(voucherRequest);
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          response: response,
          appliedVoucher: voucherRequest.insertVoucher ?? ""
        ),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
          response: const VoucherResponse(),
          appliedVoucher: ""
        ),
      );
    }
  }
}
