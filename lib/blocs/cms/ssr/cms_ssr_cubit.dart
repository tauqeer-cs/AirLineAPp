import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:app/models/cms_flight.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'cms_ssr_state.dart';

class CmsSsrCubit extends Cubit<CmsSsrState> {
  CmsSsrCubit() : super(CmsSsrState());
  final _repository = CMSRepository();

  getCmsSSR(List<CMSRoute> cmsRoutes) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final ssr = cmsRoutes.firstWhere(
          (element) => element.contentType?.alias?.toLowerCase() == "ssr");
      final cmsSSRs = await _repository.getSSRContent(ssr.key ?? "");
      final ssrItems = cmsSSRs.items ?? [];
      final meal = ssrItems.firstWhereOrNull(
          (element) => element.name?.toLowerCase() == "mealgroup");
      emit(state.copyWith(
        blocState: BlocState.finished,
        mealGroups: meal?.items ?? [],
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
    }
  }
}
