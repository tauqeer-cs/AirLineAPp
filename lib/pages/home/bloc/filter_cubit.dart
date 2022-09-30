import 'package:app/app/app_bloc_helper.dart';
import 'package:app/models/airports.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/ui/filter/search_flight.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  updateTripType(FlightType? flightType) {
    emit(state.copyWith(flightType: flightType));
  }

  updatePassengers({
    required PeopleType type,
    required bool isAdd,
  }) {
    final persons = state.numberPerson;
    int adults = persons.numberOfAdult;
    int children = persons.numberOfChildren;
    int infants = persons.numberOfInfant;
    switch (type) {
      case PeopleType.adults:
        isAdd ? adults++ : adults--;
        break;
      case PeopleType.children:
        isAdd ? children++ : children--;
        break;
      case PeopleType.infants:
        isAdd ? infants++ : infants--;
        break;
    }
    final passengers = NumberPerson(
        numberOfInfant: infants,
        numberOfChildren: children,
        numberOfAdult: adults);
    emit(state.copyWith(numberPerson: passengers));
  }

  updateOriginAirport(Airports? destination) {
    emit(FilterState(
      returnDate: state.returnDate,
      destination: null,
      blocState: state.blocState,
      message: state.message,
      departDate: state.departDate,
      flightType: state.flightType,
      numberPerson: state.numberPerson,
      origin: destination,
    ));
  }

  updateDestinationAirport(Airports? destination) {
    emit(state.copyWith(destination: destination));
  }

  updateDate({DateTime? departDate, DateTime? returnDate}) {
    emit(FilterState(
      returnDate: returnDate,
      destination: null,
      blocState: state.blocState,
      message: state.message,
      departDate: departDate,
      flightType: state.flightType,
      numberPerson: state.numberPerson,
      origin: state.origin,
    ));
  }
}
