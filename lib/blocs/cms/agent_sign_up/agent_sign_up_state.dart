part of 'agent_sign_up_cubit.dart';

class AgentSignUpState extends Equatable {
  final BlocState blocState;
  final String message;
  final AgentSignUpCms? agentCms;

  final String? mealNotEnoughTimeWarning;

  final Items? internationalItem;
  final Items? locationItem;

  final String? meal24Title;
  final String? mean24Content;
  final String? carryOnBaggedContent;
  final String? oversizedItemDescription;

  final String? bundle1HoursMessage;

  final String? yptaMessage;
  final UniversalSharedSettingsRoutesResponse? userSharedRouteResponse;

  final String? seatEmergencyExitWarning;

  final String? travelKidsMessage;

  final String? bundle24HoursMessage;

  final String? language;
  const AgentSignUpState( this.language, {
    this.blocState = BlocState.initial,
    this.message = '',
    this.agentCms,
    this.userSharedRouteResponse,
    this.internationalItem,
    this.locationItem,
    this.meal24Title,
    this.mean24Content,
    this.carryOnBaggedContent,
    this.oversizedItemDescription,
    this.yptaMessage,
    this.seatEmergencyExitWarning,
    this.mealNotEnoughTimeWarning,
    this.travelKidsMessage,
    this.bundle24HoursMessage,
    this.bundle1HoursMessage,
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
    String? carryOnBaggedContent,
    String? oversizedItemDescription,
    String? yptaMessage,
    String? seatEmergencyExitWarning,
    String? mealNotEnoughTimeWarning,
    String? travelKidsMessage,
    String? bundle24HoursMessage,
    String? bundle1HoursMessage,
  }) {
    return AgentSignUpState(
      language,
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      agentCms: agentCms ?? this.agentCms,
      userSharedRouteResponse:
      userSharedRouteResponse ?? this.userSharedRouteResponse,
      internationalItem: internationalItem ?? this.internationalItem,
      locationItem: locationItem ?? this.locationItem,
      meal24Title: meal24Title ?? this.meal24Title,
      mean24Content: mean24Content ?? this.mean24Content,
      carryOnBaggedContent: carryOnBaggedContent ?? this.carryOnBaggedContent,
      oversizedItemDescription:
      oversizedItemDescription ?? this.oversizedItemDescription,
      yptaMessage: yptaMessage ?? this.yptaMessage,
      seatEmergencyExitWarning:
      seatEmergencyExitWarning ?? this.seatEmergencyExitWarning,
      mealNotEnoughTimeWarning:
      mealNotEnoughTimeWarning ?? this.mealNotEnoughTimeWarning,
      travelKidsMessage: travelKidsMessage ?? this.travelKidsMessage,
      bundle24HoursMessage: bundle24HoursMessage ?? this.bundle24HoursMessage,
      bundle1HoursMessage: bundle1HoursMessage ?? this.bundle1HoursMessage,
    );
  }

  @override
  List<Object?> get props => [
    blocState,
    message,
    agentCms,
    userSharedRouteResponse,
    meal24Title,
    mean24Content,
    carryOnBaggedContent,
    oversizedItemDescription,
    yptaMessage,
    seatEmergencyExitWarning,
    mealNotEnoughTimeWarning,
    travelKidsMessage,
    bundle24HoursMessage,
    bundle1HoursMessage,
    language,
  ];
}
