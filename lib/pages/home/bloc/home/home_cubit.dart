import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/models/home_content.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  final _repository = CMSRepository();

  getContents(List<CMSRoute> routes) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final homeId = routes.firstWhere(
              (element) => element.contentType?.alias?.toLowerCase() == "home");
      final response = await _repository.getHomeContent(homeId.key ?? "");
      emit(state.copyWith(
        blocState: BlocState.finished,
        contents: response.items ?? [],
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }
}
