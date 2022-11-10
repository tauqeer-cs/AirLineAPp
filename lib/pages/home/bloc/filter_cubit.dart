import 'package:app/app/app_bloc_helper.dart';
import 'package:app/models/airports.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/utils/string_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  updatePromoCode(String? promoCode) {
    emit(state.copyWith(promoCode: promoCode));
  }

  updateTripType(FlightType? flightType) {
    emit(state.copyWith(flightType: flightType));
  }

  updatePassengers({
    required PeopleType type,
    required bool isAdd,
  }) {
    final numberPerson = state.numberPerson;
    final persons = List<Person>.from(numberPerson.persons);
    if(isAdd){
      int adults = numberPerson.numberOfAdult;
      int children = numberPerson.numberOfChildren;
      int infants = numberPerson.numberOfInfant;
      late Person person;
      switch (type) {
        case PeopleType.adult:
          adults++;
          person = Person(peopleType: type, numberOrder: adults);
          break;
        case PeopleType.child:
          children++;
          person = Person(peopleType: type, numberOrder: children);
          break;
        case PeopleType.infant:
          infants++;
          person = Person(peopleType: type, numberOrder: infants);
          break;
      }
      persons.add(person);
    }else{
      final index= persons.lastIndexWhere((element) => element.peopleType == type);
      persons.removeAt(index);
    }
    final newNumberPerson = NumberPerson(persons: persons);
    emit(state.copyWith(numberPerson: newNumberPerson));
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
      destination: state.destination,
      blocState: state.blocState,
      message: state.message,
      departDate: departDate,
      flightType: state.flightType,
      numberPerson: state.numberPerson,
      origin: state.origin,
    ));
  }
}
