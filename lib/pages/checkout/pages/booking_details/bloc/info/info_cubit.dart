import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<Map<String, String>> {
  InfoCubit() : super({});

  updateMap(String key, String value){
    final newMap = Map<String, String>.from(state);
    if(state.containsKey(key)){
      newMap.update(key, (oldValue) => value);
    }else{
      newMap.putIfAbsent(key, () => value);
    }
    emit(newMap);
  }
}
