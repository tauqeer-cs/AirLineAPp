import 'package:app/models/number_person.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../add_on/baggage/ui/baggage_notice.dart';

part 'selected_person_state.dart';

class SelectedPersonCubit extends Cubit<Person?> {
  SelectedPersonCubit() : super(null);

  void changePerson(Person? person) async {
  await Future.delayed(Duration(seconds: 1));

  emit(person?.copyWith());

}
  selectPerson(Person? person){
    personSingle.selectedPerson = null;

    emit(person?.copyWith());
  }

  void updatePerson(Person responseFlag) {
    emit(responseFlag);
  }
}
