import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/reverify_pnr_request.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/data/requests/verify_request.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'booking_state.dart';

part 'booking_cubit.g.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());
  final _repository = FlightRepository();

  final List<Color> availableSeatsColor = [
    Colors.blue,
    Colors.greenAccent,
    Colors.green,
    Colors.yellowAccent,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.orange,
    Colors.purple,
    Colors.purpleAccent,
  ];

  resetState() {
    emit(const BookingState());
  }

  selectDeparture(InboundOutboundSegment segment) {
    emit(state.copyWith(selectedDeparture: segment));
  }

  selectReturn(InboundOutboundSegment segment) {
    emit(state.copyWith(selectedReturn: segment));
  }

  removeDeparture() {
    emit(state.copyWithNull(selectedDeparture: true));
  }

  removeReturn() {
    emit(state.copyWithNull(selectedReturn: true));
  }

  changeFlight() {
    emit(state.copyWith(isVerify: false));
  }

  summaryFlight(SummaryRequest? summaryRequest) {
    emit(state.copyWith(summaryRequest: summaryRequest));
  }

  updateSuperPnrNo(String? superPnrNo) {
    emit(state.copyWith(superPnrNo: superPnrNo));
  }

  verifyFlight(FilterState? filterState) async {
    if (filterState == null) return;
    emit(state.copyWith(blocState: BlocState.loading, isVerify: false));
    try {
      final inboundLFID = state.selectedReturn?.lfid;
      final inboundFBCode = state.selectedReturn?.fbCode;
      final outboundLFID = state.selectedDeparture?.lfid;
      final outboundFBCode = state.selectedDeparture?.fbCode;
      final inboundFares =
          OutboundFares(fbCode: inboundFBCode, lfid: inboundLFID);
      final outboundFares =
          OutboundFares(fbCode: outboundFBCode, lfid: outboundLFID);

      final request = VerifyRequest.fromBooking(
        filterState,
        inbound: (inboundLFID == null || inboundFBCode == null)
            ? []
            : [inboundFares],
        outbound: (outboundLFID == null || outboundFBCode == null)
            ? []
            : [outboundFares],
        totalAmount: state.getFinalPrice,
      );
      final verifyResponse = await _repository.verifyFlight(request);
      final seatsDeparture =
          verifyResponse.flightSSR?.seatGroup?.outbound ?? [];
      final seatsReturn = verifyResponse.flightSSR?.seatGroup?.inbound ?? [];

      final Map<num?, Color> departureColorMapping = {};
      final Map<num?, Color> returnColorMapping = {};
      for (int i = 0; i < seatsDeparture.length; i++) {
        final seat = seatsDeparture[i];
        departureColorMapping.putIfAbsent(
            seat.serviceID, () => availableSeatsColor[i]);
      }
      for (int i = 0; i < seatsReturn.length; i++) {
        final seat = seatsReturn[i];
        returnColorMapping.putIfAbsent(
            seat.serviceID, () => availableSeatsColor[i]);
      }
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          verifyResponse: verifyResponse,
          isVerify: true,
          departureColorMapping: departureColorMapping,
          returnColorMapping: returnColorMapping,
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

  reVerifyFlight(FilterState? filterState) async {
    if (filterState == null) return;
    emit(state.copyWith(blocState: BlocState.loading, isVerify: false));
    try {
      final inboundLFID = state.selectedReturn?.lfid;
      final inboundFBCode = state.selectedReturn?.fbCode;
      final outboundLFID = state.selectedDeparture?.lfid;
      final outboundFBCode = state.selectedDeparture?.fbCode;
      final inboundFares =
          OutboundFares(fbCode: inboundFBCode, lfid: inboundLFID);
      final outboundFares =
          OutboundFares(fbCode: outboundFBCode, lfid: outboundLFID);

      final request = VerifyRequest.fromBooking(
        filterState,
        inbound: (inboundLFID == null || inboundFBCode == null)
            ? []
            : [inboundFares],
        outbound: (outboundLFID == null || outboundFBCode == null)
            ? []
            : [outboundFares],
        totalAmount: state.getFinalPrice,
        flightSummaryPnrRequest: state.summaryRequest?.flightSummaryPNRRequest,
      );
      final verifyResponse = await _repository.reVerifyFlight(request);
      final newToken = state.verifyResponse?.copyWith(
        verifyExpiredDateTime: verifyResponse.verifyExpiredDateTime,
        token: verifyResponse.token,
      );
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          verifyResponse: newToken,
          isVerify: true,
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

  reVerifyPNR() async {
    if (state.superPnrNo == null) return;
    emit(state.copyWith(blocState: BlocState.loading, isVerify: false));
    try {
      final verifyResponse = await _repository.reverifyPnr(
        ReverifyPnrRequest(superPNRNo: state.superPnrNo),
      );
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          superPnrNo: verifyResponse.result?.value?.superPnrNo,
          isVerify: true,
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
