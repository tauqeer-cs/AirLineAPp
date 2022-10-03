import 'package:app/models/number_person.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_person_state.dart';

class SelectedPersonCubit extends Cubit<Person?> {
  SelectedPersonCubit() : super(null);

  selectPerson(Person? person){
    emit(person);
  }
}
