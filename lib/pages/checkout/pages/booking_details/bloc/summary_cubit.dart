import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/data/requests/token_request.dart';
import 'package:app/data/responses/summary_response.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/requests/promotion_request.dart';
import '../../../../../data/responses/promotions_response.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(SummaryState());
  final _repository = FlightRepository();

  selectedItem(AvailableRedeemOptions option) {

    emit(
      state.copyWith(
        selectedRedeemOption: option
      )
    );
  }


  AvailableRedeemOptions? get getSelectedItem {
    return state.selectedRedeemOption;
  }

  getAvailablePromotions() async {
    if (state.promoLoaded) {
      return;
    }
    final response = await _repository
        .getPromoInfo(Token(token: state.summaryRequest!.token));
    print('object');
    if (response.statusCode == 200) {
      emit(state.copyWith(
        blocState: BlocState.finished,
        redemptionOption: response.value!.lmsRedemptionOption,
        promoReady: true,
      ));
    } else {
      emit(state.copyWith(
        blocState: BlocState.finished,
        redemptionOption: response.value!.lmsRedemptionOption,
        promoReady: false,
      ));
    }
  }

  submitSummary(SummaryRequest summaryRequest) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final response = await _repository.summaryFlight(summaryRequest);
      emit(state.copyWith(
        blocState: BlocState.finished,
        summaryResponse: response,
        summaryRequest: summaryRequest,
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
