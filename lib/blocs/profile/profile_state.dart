part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Profile? profile;
  final BlocState blocState;
  final String message;
  final bool updatingFnF;

  final bool errorWhileAddingFnf;
  final bool addingFamily;
  final bool deleteMember;
  final String? deletingId;

  const ProfileState({
    this.addingFamily = false,
    this.deleteMember = false,
    this.profile,
    this.blocState = BlocState.initial,
    this.message = '',
    this.errorWhileAddingFnf = false,
    this.deletingId,
    this.updatingFnF = false,
  });

  ProfileState copyWith({
    BlocState? blocState,
    String? message,
    Profile? profile,
    bool? addingFnF,
    bool? updatingFnF,
    bool? errorWhileAddingFnf,
    bool? deletedFnf,
    String? deletingId,
  }) {
    return ProfileState(
        blocState: blocState ?? this.blocState,
        message: message ?? this.message,
        profile: profile ?? this.profile,
        addingFamily: addingFnF ?? addingFamily,
        errorWhileAddingFnf: errorWhileAddingFnf ?? this.errorWhileAddingFnf,
        deleteMember: deletedFnf ?? deleteMember,
        deletingId: deletingId ?? this.deletingId,
      updatingFnF: updatingFnF ?? this.updatingFnF,

    );
  }

  @override
  List<Object?> get props => [
        profile,
        blocState,
        message,
        errorWhileAddingFnf,
        addingFamily,
        deleteMember,
        deletingId,
    updatingFnF,
      ];
}
