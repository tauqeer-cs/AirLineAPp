import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:app/data/responses/home_detail.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_detail_state.dart';

class HomeDetailCubit extends Cubit<HomeDetailState> {
  HomeDetailCubit() : super(const HomeDetailState());
  final _repository = CMSRepository();

  getContents(String url, List<CMSRoute> routes) async {
    try {
      var contentId = routes.firstWhereOrNull(
          (element) => url.replaceAll("/", "")==element.urlSegment);
      if (contentId?.key == null) {
        await Future.delayed(const Duration(milliseconds: 300));
        emit(
          state.copyWith(
              message: "The page is not found", blocState: BlocState.failed),
        );
        return;
      }
      emit(state.copyWith(blocState: BlocState.loading));
      final response = await _repository.getContentDetail(contentId!.key!);
      emit(state.copyWith(
        blocState: BlocState.finished,
        content: response,
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
