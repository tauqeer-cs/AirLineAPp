import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'routes_state.dart';

class RoutesCubit extends Cubit<RoutesState> {
  RoutesCubit() : super(const RoutesState());
  final _repository = CMSRepository();

  getRoutes() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final routes = await _repository.getRoutes();
      emit(state.copyWith(
        blocState: BlocState.finished,
        routes: routes,
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
