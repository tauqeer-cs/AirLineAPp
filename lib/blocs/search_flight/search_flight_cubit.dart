import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/airports.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_flight_state.dart';

class SearchFlightCubit extends Cubit<SearchFlightState> {
  SearchFlightCubit() : super(SearchFlightState());
  final _repository = FlightRepository();

  addBundleToPerson(Person? person, InboundBundle? bundle, bool isDeparture) {
    final persons =
        List<Person>.from(state.filterState?.numberPerson.persons ?? []);
    final selected = persons.indexWhere((element) => element == person);
    if (selected >= 0) {
      final person = persons[selected];
      final newPerson = isDeparture
          ? person.copyWith(departureBundle: () => bundle)
          : person.copyWith(returnBundle: () => bundle);
      persons.removeAt(selected);
      persons.insert(selected, newPerson);
      final newNumberPerson = NumberPerson(persons: persons);
      final filterState =
          state.filterState?.copyWith(numberPerson: newNumberPerson);
      emit(
        state.copyWith(
            filterState: filterState,
            message: "${DateTime.now().millisecondsSinceEpoch}"),
      );
    }
  }

  searchFlights(FilterState filterState) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final request = SearchFlight.fromFilter(filterState);
      final airports = await _repository.searchFlight(request);
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          filterState: filterState,
          flights: airports.searchFlightResponse,
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
