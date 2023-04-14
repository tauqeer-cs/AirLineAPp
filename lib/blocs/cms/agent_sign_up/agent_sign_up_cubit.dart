import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../data/repositories/cms_repository.dart';
import '../../../data/responses/agent_sign_up_cms.dart';
import '../../../models/cms_route.dart';

part 'agent_sign_up_state.dart';

class AgentSignUpCubit extends Cubit<AgentSignUpState> {
  AgentSignUpCubit() : super(const AgentSignUpState());

  final _repository = CMSRepository();

  getAgentSignUp(List<CMSRoute> cmsRoutes) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final universalSetting = cmsRoutes.firstWhereOrNull((element) =>
      element.contentType?.alias ==
          "agentSignUp");

      var universalSetting2 = cmsRoutes.firstWhereOrNull((element) =>
      element.name ==
          "Universal Shared Settings");

      var universalSetting22 = universalSetting2?.items?.where((element) => element.contentType?.alias == 'sSR').toList();

      String key = '';
      if(universalSetting22?.isNotEmpty ?? true) {
        key = universalSetting22!.first.key ?? '';

      }
      //InsuranceTypeSSR

      if (universalSetting == null) {
        emit(state.copyWith(
          blocState: BlocState.finished,
        ));
        return;
      }
     // final agentCms =
     // await _repository.agentSignUp(universalSetting.key ?? "");


      if(key.isNotEmpty) {
        final agentCms2 = await _repository.agenInsurance(key);
      }



      emit(state.copyWith(
        blocState: BlocState.finished,
      //agentCms: agentCms
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
