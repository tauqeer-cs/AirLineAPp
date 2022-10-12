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
      final universalSetting = cmsRoutes.firstWhereOrNull(
          (element) => element.contentType?.alias?.toLowerCase() == "universalsharedsettings");

      if(universalSetting == null){
        emit(state.copyWith(
          blocState: BlocState.finished,
          mealGroups: [],
        ));
        return;
      }
      final cmsSSRs = await _repository.getSSRContent(universalSetting.key ?? "");
      final ssr = cmsSSRs.items?.firstWhereOrNull((element) => element.name?.toLowerCase()=="ssr");
      final notifications = cmsSSRs.items?.firstWhereOrNull(
              (element) => element.name?.toLowerCase() == "notification alert");
      final yptaMessage = cmsSSRs.items?.firstWhereOrNull(
              (element) => element.name?.toLowerCase() == "ypta message");
      final ssrItems = ssr?.items ?? [];
      final meal = ssrItems.firstWhereOrNull(
          (element) => element.name?.toLowerCase() == "mealgroup");
      emit(state.copyWith(
        blocState: BlocState.finished,
        mealGroups: meal?.items ?? [],
        notifications: notifications?.items ?? [],
        notice: yptaMessage,
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
