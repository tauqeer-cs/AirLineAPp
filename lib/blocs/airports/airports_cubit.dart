import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/models/airports.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'airports_state.dart';

class AirportsCubit extends Cubit<AirportsState> {
  AirportsCubit() : super(AirportsState());
  final _repository = FlightRepository();

  getAirports() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final airports = await _repository.getAirports();
      emit(state.copyWith(
        blocState: BlocState.finished,
        airports: airports.airports ?? [],
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }
}
