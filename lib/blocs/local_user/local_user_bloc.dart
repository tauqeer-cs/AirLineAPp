import 'dart:async';

import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/list_of_passenger_info.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'local_user_event.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleRestartable<E>(Duration duration) {
  return (events, mapper) {
    return sequential<E>().call(events.throttle(duration), mapper);
  };
}

class LocalUserBloc extends Bloc<LocalUserEvent, FlightSummaryPnrRequest> {
  final _repository = LocalRepository();

  LocalUserBloc() : super(FlightSummaryPnrRequest()) {
    on<Init>(
      _onInit,
    );
    on<UpdateEmailContact>(_onUpdateEmailContact);
    on<UpdateEmergency>(_onUpdateEmergency);
    on<UpdateCompany>(_onUpdateCompany);
  }

  void _onInit(
    Init event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) async {
    final storage = _repository.getPassengerInfo();
    emit(storage);
  }

  void _onUpdateEmailContact(
    UpdateEmailContact event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) {
    print("event email ${event.email} , is emitter alive: ${!emit.isDone}");
    final newEmail = state.copyWith(contactEmail: event.email);
    if (emit.isDone) return;
    print(
        'Finished event email ${event.email}, is emitter alive: ${!emit.isDone}');
    _repository.setPassengerInfo(newEmail);
    emit(newEmail);
  }

  void _onUpdateEmergency(
    UpdateEmergency event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) async {
    emit(state.copyWith(emergencyContact: event.emergencyContact));
    _repository.setPassengerInfo(state);
  }

  void _onUpdateCompany(
    UpdateCompany event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) async {
    emit(state.copyWith(companyTaxInvoice: event.companyInfo));
    _repository.setPassengerInfo(state);
  }
}
