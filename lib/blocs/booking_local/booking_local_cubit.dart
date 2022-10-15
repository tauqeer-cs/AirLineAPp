import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:app/models/booking_local.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_local_state.dart';

class BookingLocalCubit extends Cubit<BookingLocalState> {
  final _repository = LocalRepository();

  BookingLocalCubit() : super(BookingLocalState());

  saveBooking(BookingLocal bookingLocal){
    final list = List<BookingLocal>.from(state.bookings);
    _repository.saveBooking(bookingLocal);
    list.add(bookingLocal);
    emit(state.copyWith(bookings: list));
  }

  getBooking(){
    final list = _repository.getBooking();
    emit(state.copyWith(bookings: list));
  }
}
