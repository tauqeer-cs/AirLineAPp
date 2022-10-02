import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/verify_request.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingState());
  final _repository = FlightRepository();

  selectDeparture(InboundOutboundSegment segment) {
    emit(state.copyWith(selectedDeparture: segment));
  }

  selectReturn(InboundOutboundSegment segment) {
    emit(state.copyWith(selectedReturn: segment));
  }

  changeVerify(bool isVerify) {
    emit(state.copyWith(isVerify: isVerify));
  }

  verifyFlight(FilterState filterState) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final inboundLFID = state.selectedReturn?.lfid != null
          ? [state.selectedReturn!.lfid!.toInt()]
          : null;
      final outboundLFID = state.selectedDeparture?.lfid != null
          ? [state.selectedDeparture!.lfid!.toInt()]
          : null;

      final request = VerifyRequest.fromBooking(filterState,
          inbound: inboundLFID,
          outbound: outboundLFID,
          totalAmount: state.getFinalPrice);
      final verifyResponse = await _repository.verifyFlight(request);
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          verifyResponse: verifyResponse,
        ),
      );
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
