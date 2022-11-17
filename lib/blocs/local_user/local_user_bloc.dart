import 'package:app/data/repositories/local_repositories.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    on<UpdateData>(_onUpdateData);
  }

  void _onInit(
    Init event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) async {
    final storage = _repository.getPassengerInfo();
    emit(storage);
  }

  void _onUpdateData(
    UpdateData event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) {
    if (event.data == null) return;
    _repository.setPassengerInfo(event.data!);
    emit(event.data!);

  }

  void _onUpdateEmailContact(
    UpdateEmailContact event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) {
    final newEmail = state.copyWith(contactEmail: event.email);
    _repository.setPassengerInfo(newEmail);
    emit(newEmail);
  }

  void _onUpdateEmergency(
    UpdateEmergency event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) async {
    final emergency = state.copyWith(emergencyContact: event.emergencyContact);
    _repository.setPassengerInfo(emergency);
    emit(emergency);
  }

  void _onUpdateCompany(
    UpdateCompany event,
    Emitter<FlightSummaryPnrRequest> emit,
  ) async {
    final company = state.copyWith(companyTaxInvoice: event.companyInfo);
    _repository.setPassengerInfo(company);
    emit(company);
  }
}
