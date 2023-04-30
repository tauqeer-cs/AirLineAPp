import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../data/repositories/cms_repository.dart';
import '../../../data/responses/agent_sign_up_cms.dart';
import '../../../data/responses/universal_shared_settings_routes_response.dart';
import '../../../models/cms_route.dart';

part 'agent_sign_up_state.dart';

class AgentSignUpCubit extends Cubit<AgentSignUpState> {
  AgentSignUpCubit() : super(const AgentSignUpState());

  final _repository = CMSRepository();

  getAgentSignUp(List<CMSRoute> cmsRoutes) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final universalSetting = cmsRoutes.firstWhereOrNull(
          (element) => element.contentType?.alias == "agentSignUp");

      var universalSetting2 = cmsRoutes.firstWhereOrNull(
          (element) => element.name == "Universal Shared Settings");


      if (universalSetting == null) {
        emit(state.copyWith(
          blocState: BlocState.finished,
        ));
        return;
      }
      final agentCms =
          await _repository.agentSignUp(universalSetting.key ?? "");

      final agentCms2 =
          await _repository.agenInsurance(universalSetting2?.key ?? '');


      //
      Items? items = agentCms2.items?.firstWhere((element) => element.name == 'SSR');

      Items? meal24HourItems = agentCms2.items?.firstWhere((element) => element.name == 'Meal Overtime Warning');

      String? titleMeal24;
      String? contentMeal24;

      if(meal24HourItems != null) {

        titleMeal24 = meal24HourItems.title;
        contentMeal24 = meal24HourItems.contentHtmlString;
      }
      Items? localItem;
      Items? internationItem;

      if(items != null) {
        localItem = items.items?.firstWhere((e) => e.name == 'insuranceDomesticGroup');
        internationItem = items.items?.firstWhere((e) => e.name == 'insuranceInternationalGroup');


      }

      emit(
        state.copyWith(
          meal24Title: titleMeal24,
          mean24Content: contentMeal24,
          blocState: BlocState.finished,
          agentCms: agentCms,
          userSharedRouteResponse: agentCms2,
          locationItem: localItem,
          internationalItem: internationItem
        ),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
          blocState: BlocState.failed,
        ),
      );
    }
  }
}
