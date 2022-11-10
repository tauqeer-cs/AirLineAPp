import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'summary_container_state.dart';

class SummaryContainerCubit extends Cubit<bool> {
  SummaryContainerCubit() : super(true);
  changeVisibility(bool value) => emit(value);
}
