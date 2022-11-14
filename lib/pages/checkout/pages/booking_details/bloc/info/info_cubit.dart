import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<Map<String, String>> {
  InfoCubit() : super({});

  updateMap(String key, String value){
    final newMap = Map<String, String>.from(state);
    if(state.containsKey(key)){
      print("contains key $key");
      print("contains value $value");
      newMap.update(key, (oldValue) => value);
    }else{
      print("not contains key $key");
      newMap.putIfAbsent(key, () => value);
    }
    print("new map $newMap");

    emit(newMap);
  }
}
