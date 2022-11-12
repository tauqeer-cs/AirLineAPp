import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoInitial());
}
