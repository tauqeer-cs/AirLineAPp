import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'search_flight_state.dart';

class SearchFlightCubit extends Cubit<SearchFlightState> {
  SearchFlightCubit() : super(const SearchFlightState());
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

  addWheelChairToPersonPartial({
    Person? person,
    required List<Bundle> wheelChairs,
    required bool isDeparture,
    String? okId,
  }) {
    print("available wheelchair is ${wheelChairs.length}");
    final persons =
        List<Person>.from(state.filterState?.numberPerson.persons ?? []);
    Bundle? wheelChair;
    if(okId?.isNotEmpty ?? false){
      wheelChair = wheelChairs.firstWhereOrNull((element) => element.codeType == "WCHC");
    }else{
      wheelChair = wheelChairs.firstWhereOrNull((element) => element.codeType == "WCHR");
    }
    wheelChair ??= wheelChairs.firstOrNull;

    final selected = persons.indexWhere((element) {
      return element == person;
    });
    if (selected >= 0) {
      print("selected is more than 0 $wheelChair");
      final person = persons[selected];
      late Person newPerson;
      if (isDeparture) {
        newPerson = person.copyWith(
          departureWheelChair: () => wheelChair,
          departureOkId: () => okId,
        );
      } else {
        newPerson = person.copyWith(
          returnWheelChair: () => wheelChair,
          returnOkId: () => okId,
        );
      }
      persons.removeAt(selected);
      persons.insert(selected, newPerson);
      final newNumberPerson = NumberPerson(persons: persons);
      final filterState =
          state.filterState?.copyWith(numberPerson: newNumberPerson);
      emit(
        state.copyWith(
          filterState: filterState,
          message: "${DateTime.now().millisecondsSinceEpoch}",
        ),
      );
    }
  }

  updateOkIdPartial(Person? person, String? okId, {required bool isDeparture}) {
    final persons =
        List<Person>.from(state.filterState?.numberPerson.persons ?? []);
    final selected = persons.indexWhere((element) {
      return element == person;
    });
    if (selected >= 0) {
      final person = persons[selected];
      late Person newPerson;
      if (isDeparture) {
        newPerson = person.copyWith(
          departureOkId: () => okId,
        );
      } else {
        newPerson = person.copyWith(
          returnOkId: () => okId,
        );
      }
      persons.removeAt(selected);
      persons.insert(selected, newPerson);
      final newNumberPerson = NumberPerson(persons: persons);
      final filterState =
          state.filterState?.copyWith(numberPerson: newNumberPerson);
      emit(
        state.copyWith(
          filterState: filterState,
          message: "${DateTime.now().millisecondsSinceEpoch}",
        ),
      );
    }
  }

  addWheelChairToPerson(
      Person? person, Bundle? departureWheelChair, Bundle? returnWheelChair) {
    final persons =
        List<Person>.from(state.filterState?.numberPerson.persons ?? []);
    final selected = persons.indexWhere((element) => element == person);
    if (selected >= 0) {
      final person = persons[selected];
      final newPerson = person.copyWith(
        departureWheelChair: () => departureWheelChair,
        returnWheelChair: () => returnWheelChair,
      );
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

  bool addSeatToPerson(Person? person, Seats? seat, bool isDeparture) {
    try {
      final persons =
          List<Person>.from(state.filterState?.numberPerson.persons ?? []);
      final selected = persons.indexWhere((element) => element == person);
      if (selected >= 0) {
        final person = persons[selected];
        final newPerson = isDeparture
            ? person.copyWith(departureSeats: () => seat)
            : person.copyWith(returnSeats: () => seat);
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

      return true;
    } catch (e) {
      return false;
    }
  }

  addOrRemoveMealFromPerson({
    Person? person,
    required Bundle meal,
    required bool isDeparture,
    required bool isAdd,
  }) {


    final persons =
        List<Person>.from(state.filterState?.numberPerson.persons ?? []);
    final selected = persons.indexWhere((element) => element == person);

    if(isAdd) {
      if(isDeparture) {
        if((person?.departureMeal ?? []).isNotEmpty ){
          num maxCountAllowe = meal.maxCountServiceLevel ?? 0.0;
          //BDMC
          var allThisTypeOfMeal = person?.departureMeal.where((element) => element.codeType == meal.codeType).toList();

          if((allThisTypeOfMeal ?? []).isNotEmpty){

            if(allThisTypeOfMeal!.length >= maxCountAllowe) {
              return;
            }
          }


        }
      }
      else {
        if((person?.returnMeal ?? []).isNotEmpty ){
          num maxCountAllowe = meal.maxCountServiceLevel ?? 0.0;
          //BDMC
          var allThisTypeOfMeal = person?.returnMeal.where((element) => element.codeType == meal.codeType).toList();

          if((allThisTypeOfMeal ?? []).isNotEmpty){

            if(allThisTypeOfMeal!.length >= maxCountAllowe) {
              return;
            }
          }


        }
      }
    }






    if (selected >= 0) {
      final person = persons[selected];
      final meals = isDeparture
          ? List<Bundle>.from(person.departureMeal)
          : List<Bundle>.from(person.returnMeal);
      if (isAdd) {

        meals.add(meal);
        if(isAdd){
          if(meals.length == 10) {
            //return;

          }
        }
      } else {
        meals.remove(meal);
      }

      final newPerson = isDeparture
          ? person.copyWith(departureMeal: meals)
          : person.copyWith(returnMeal: meals);
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

  bool addSportEquipmentToPerson(
      Person? person, Bundle? bundle, bool isDeparture) {
    try {
      final persons =
          List<Person>.from(state.filterState?.numberPerson.persons ?? []);
      final selected = persons.indexWhere((element) => element == person);
      if (selected >= 0) {
        final person = persons[selected];
        final newPerson = isDeparture
            ? person.copyWith(departureSports: () => bundle)
            : person.copyWith(returnSports: () => bundle);
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
      return true;
    } catch (e) {
      return false;
    }
  }

  bool addBaggageToPerson(Person? person, Bundle? baggage, bool isDeparture) {
    try {
      final persons =
          List<Person>.from(state.filterState?.numberPerson.persons ?? []);
      final selected = persons.indexWhere((element) => element == person);
      if (selected >= 0) {
        final person = persons[selected];
        final newPerson = isDeparture
            ? person.copyWith(departureBaggage: () => baggage)
            : person.copyWith(returnBaggage: () => baggage);
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
      return true;
    } catch (e) {
      return false;
    }
  }

  searchFlights(FilterState filterState,String currency) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      var request = SearchFlight.fromFilter(filterState,currency);
      if(request.searchFlightRequest?.departDate != null) {
        var dateObjectDepart = DateTime.parse(request.searchFlightRequest?.departDate ?? '');

        bool isToday = isSameDay(dateObjectDepart, DateTime.now());

        if(isToday == true){


 //         request.searchFlightRequest?.departDate = ;
          var newOne = request.searchFlightRequest!.copyWith(departDate: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(DateTime.now().add(const Duration(minutes: 5))));
          request = request.copyWith(searchFlightRequest: newOne);

        }
        print('');


        if(request.searchFlightRequest?.returnDate != null) {
          var dateObjectReturn = DateTime.parse(request.searchFlightRequest?.returnDate ?? '');

          isToday = isSameDay(dateObjectReturn, DateTime.now());


          if(isToday == true){

            var newOne = request.searchFlightRequest!.copyWith(returnDate: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(DateTime.now().add(const Duration(minutes: 5))));
            request = request.copyWith(searchFlightRequest: newOne);

          }
        }


      }
      final airports = await _repository.searchFlightRepo(request);
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          filterState: filterState,
          flights: airports.searchFlightResponse,
          visaPromo: airports.isVisaCampaign,
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

  resetFilterState(FilterState filterState) async {
    final newFilterState = filterState.copyWith(
      numberPerson: NumberPerson(
          persons: List<Person>.from(filterState.numberPerson.persons)),
    );

    emit(state.copyWith(
        filterState: newFilterState,
        message: DateTime.now().millisecondsSinceEpoch.toString()));
  }

  void addInsuranceToPerson(int i, Bundle insurance) {
    state.filterState!.numberPerson.persons[i] = state
        .filterState!.numberPerson.persons[i]
        .copyWith(insurance: insurance);
  }

  void removeInsuranceAll() {
    for (int i = 0; i < state.filterState!.numberPerson.persons.length; i++) {
      removeInsuranceFromPerson(i);
    }
  }

  void removeInsuranceFromPerson(int i) {
    state.filterState!.numberPerson.persons[i] = state
        .filterState!.numberPerson.persons[i]
        .copyWith(insuranceEmpty: true);
  }

  bool showInsuranceCheck() {
    for (int i = 0; i < state.filterState!.numberPerson.persons.length; i++) {
      if (state.filterState!.numberPerson.persons[i].insuranceGroup != null) {
        return true;
      }
    }
    return false;
  }
}
