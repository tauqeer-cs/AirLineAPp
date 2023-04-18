part of 'agent_sign_up_cubit.dart';


class AgentSignUpState extends Equatable {

  final BlocState blocState;
  final String message;
  final AgentSignUpCms? agentCms;

  final Items? internationalItem;
  final Items? locationItem;

  final UniversalSharedSettingsRoutesResponse? userSharedRouteResponse;


  const AgentSignUpState({
    this.blocState = BlocState.initial,
    this.message = '',
    this.agentCms,
    this.userSharedRouteResponse,
    this.internationalItem,
    this.locationItem,

  });

  AgentSignUpState copyWith({
    BlocState? blocState,
    String? message,
    AgentSignUpCms? agentCms,
    UniversalSharedSettingsRoutesResponse? userSharedRouteResponse,
    Items? internationalItem,
    Items? locationItem,
  }) {
    return AgentSignUpState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      agentCms: agentCms ?? this.agentCms,
      userSharedRouteResponse: userSharedRouteResponse ?? this.userSharedRouteResponse,
      internationalItem: internationalItem ?? this.internationalItem,
      locationItem: locationItem ?? this.locationItem,
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
