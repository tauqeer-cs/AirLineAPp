import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'is_departure_state.dart';

class IsDepartureCubit extends Cubit<bool> {
  IsDepartureCubit() : super(true);

  changeDeparture(bool isDeparture){
    emit(isDeparture);
  }
}
