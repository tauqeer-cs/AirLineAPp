part of 'agent_sign_up_cubit.dart';


class AgentSignUpState extends Equatable {

  final BlocState blocState;
  final String message;
  final AgentSignUpCms? agentCms;

  final Items? internationalItem;
  final Items? locationItem;

  final String? meal24Title;
  final String? mean24Content;

  final UniversalSharedSettingsRoutesResponse? userSharedRouteResponse;


  const AgentSignUpState({
    this.blocState = BlocState.initial,
    this.message = '',
    this.agentCms,
    this.userSharedRouteResponse,
    this.internationalItem,
    this.locationItem,
    this.meal24Title,
    this.mean24Content

  });

  AgentSignUpState copyWith({
    BlocState? blocState,
    String? message,
    AgentSignUpCms? agentCms,
    UniversalSharedSettingsRoutesResponse? userSharedRouteResponse,
     Items? internationalItem,
     Items? locationItem,
    String? meal24Title,
     String? mean24Content,
  }) {
    return AgentSignUpState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      agentCms: agentCms ?? this.agentCms,
      userSharedRouteResponse: userSharedRouteResponse ?? this.userSharedRouteResponse,
      internationalItem: internationalItem ?? this.internationalItem,
      locationItem: locationItem ?? this.locationItem,
      meal24Title: meal24Title ?? this.meal24Title,
      mean24Content: mean24Content ?? this.mean24Content,

    );
  }

  @override
  List<Object?> get props => [
    blocState,
    message,
    agentCms,
    userSharedRouteResponse,
    meal24Title,
    mean24Content
  ];
}
