part of 'agent_sign_up_cubit.dart';


class AgentSignUpState extends Equatable {

  final BlocState blocState;
  final String message;
  final AgentSignUpCms? agentCms;

  final UniversalSharedSettingsRoutesResponse? userSharedRouteResponse;


  const AgentSignUpState({
    this.blocState = BlocState.initial,
    this.message = '',
    this.agentCms,
    this.userSharedRouteResponse,
  });

  AgentSignUpState copyWith({
    BlocState? blocState,
    String? message,
    AgentSignUpCms? agentCms,
    UniversalSharedSettingsRoutesResponse? userSharedRouteResponse,
  }) {
    return AgentSignUpState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      agentCms: agentCms ?? this.agentCms,
      userSharedRouteResponse: userSharedRouteResponse ?? this.userSharedRouteResponse,
    );
  }

  @override
  List<Object?> get props => [
    blocState,
    message,
    agentCms,
    userSharedRouteResponse,
  ];
}
