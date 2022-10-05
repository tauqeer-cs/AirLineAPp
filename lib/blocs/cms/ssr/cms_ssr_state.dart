part of 'cms_ssr_cubit.dart';

class CmsSsrState extends Equatable {
  final List<SSRItemType> mealGroups;
  final BlocState blocState;
  final String message;

  const CmsSsrState({
    this.mealGroups =const [],
    this.blocState = BlocState.initial,
    this.message = '',
  });
  CmsSsrState copyWith({
    BlocState? blocState,
    String? message,
    List<SSRItemType>? mealGroups,
  }) {
    return CmsSsrState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      mealGroups: mealGroups ?? this.mealGroups,
    );
  }
  @override
  List<Object?> get props => [mealGroups, blocState, message];
}

