import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/data/responses/voucher_response.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(const VoucherState());
  final _repository = FlightRepository();

  resetState() {
    emit(const VoucherState());
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
