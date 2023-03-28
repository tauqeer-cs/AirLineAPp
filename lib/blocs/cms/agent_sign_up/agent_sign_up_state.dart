part of 'agent_sign_up_cubit.dart';


class AgentSignUpState extends Equatable {

  final BlocState blocState;
  final String message;
  final AgentSignUpCms? agentCms;


  const AgentSignUpState({
    this.blocState = BlocState.initial,
    this.message = '',
    this.agentCms,
  });

  AgentSignUpState copyWith({
    BlocState? blocState,
    String? message,
    AgentSignUpCms? agentCms,

  }) {
    return AgentSignUpState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      agentCms: agentCms ?? this.agentCms,
    );
  }

  @override
  List<Object?> get props => [
    blocState,
    message,
    agentCms,
  ];
}
