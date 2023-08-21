import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/data/responses/voucher_response.dart';
import 'package:app/utils/error_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_insider/flutter_insider.dart';

import '../../data/requests/token_request.dart';
import '../../data/responses/promotions_response.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(VoucherState());
  final _repository = FlightRepository();

  resetState() {
    emit(VoucherState());
  }

  dontShowVoucher() async {

    emit(state.copyWith(
      dontShowVoucher: true,
    ));


  }

  bool get hasVoucherBeenUsed {

    if(state.response?.addVoucherResult?.voucherDiscounts != null) {

      if((state.response?.addVoucherResult?.voucherDiscounts ?? []) .isNotEmpty) {
        var discount = state.response?.addVoucherResult?.voucherDiscounts!.first.discountAmount;

        if((discount ?? 0.0) > 0.0) {
          return true;
        }
      }
    }
    return false;

  }
  bool get hasPointsBeenRedeemed {

    if(state.redemptionOption?.availableOptions  != null) {

      if(state.redemptionOption!.availableOptions!.isNotEmpty) {

        if(state.selectedRedeemOption != null) {
          var amount = state.selectedRedeemOption?.redemptionAmount ?? 0.0;

          if(amount > 0 ){

            return true;

          }
        }

      }


    }

    return false;
  }
  getAvailablePromotions(String token) async {
    state.flightToken = token;


    final response = await _repository.getPromoInfo(Token(token: token));

    if (response.statusCode == 200) {
      emit(state.copyWith(
        redemptionOption: response.value!.lmsRedemptionOption,
        promoReady: true,
      ));
      return;
    } else {
      emit(state.copyWith(
        promoReady: true,
      ));
      return;
    }
  }

  AvailableRedeemOptions? get getSelectedItem {
    return state.selectedRedeemOption;
  }

  selectedItem(AvailableRedeemOptions option) {
    emit(state.copyWith(selectedRedeemOption: option));
  }

  addVoucher(VoucherRequest voucherRequest) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final response = await _repository.addVoucher(voucherRequest);
      FlutterInsider.Instance.tagEvent(
        InsiderConstants.promoCodeApplied,
      )
          .addParameterWithString(
            "voucher_name",
            voucherRequest.voucherPins.firstOrNull?.voucherCode ??
                voucherRequest.insertVoucher ??
                "",
          )
          .build();
      if(response.addVoucherResult?.voucherDiscounts != null) {
        if((response.addVoucherResult?.voucherDiscounts ?? []).isNotEmpty ) {

          if((response.addVoucherResult?.voucherDiscounts ?? []).first.discountAmount == 0.0) {
            emit(
              state.copyWith(
                dontShowVoucher: false,
                message: 'Voucher out of balance',
                blocState: BlocState.failed,
                response: () => const VoucherResponse(),
                appliedVoucher: () => "",
                insertedVoucher: null,
              ),
            );
            return;

          }
        }
        else {
          emit(
            state.copyWith(
              dontShowVoucher: false,
              message: 'Voucher out of balance',
              blocState: BlocState.failed,
              response: () => const VoucherResponse(),
              appliedVoucher: () => "",
              insertedVoucher: null,
            ),
          );

          return;

        }
      }emit(
        state.copyWith(
          blocState: BlocState.finished,
          response: () => response,
          dontShowVoucher: false,
          appliedVoucher: () => voucherRequest.insertVoucher,
          insertedVoucher: () => voucherRequest.voucherPins.firstOrNull,
        ),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
          dontShowVoucher: false,
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
          response: () => const VoucherResponse(),
          appliedVoucher: () => "",
          insertedVoucher: null,
        ),
      );
    }
  }

  removeVoucher(VoucherRequest voucherRequest,{String? lastTextEntered}) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      await _repository.removeVoucher(voucherRequest);
      emit(
        state.copyWith(
          dontShowVoucher: false,
          blocState: BlocState.finished,
          response: () => null,
          lastText: lastTextEntered,
          appliedVoucher: () => null,
          insertedVoucher: () => null,
        ),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
          dontShowVoucher: false,
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
          response: () => const VoucherResponse(),
          appliedVoucher: () => "",
        ),
      );
    }
  }

}
