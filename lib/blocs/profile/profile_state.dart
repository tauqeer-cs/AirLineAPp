part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Profile? profile;
  final BlocState blocState;
  final String message;

  const ProfileState({
    this.profile,
    this.blocState = BlocState.initial,
    this.message = '',
  });

  ProfileState copyWith({
    BlocState? blocState,
    String? message,
    Profile? profile,
  }) {
    return ProfileState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [profile, blocState, message];
}
