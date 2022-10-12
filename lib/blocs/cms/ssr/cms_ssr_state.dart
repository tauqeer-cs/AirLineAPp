part of 'cms_ssr_cubit.dart';

class CmsSsrState extends Equatable {
  final List<SSRItemType> mealGroups;
  final List<SSRItem>? notifications;
  final SharedSetting? notice;
  final BlocState blocState;
  final String message;

  const CmsSsrState({
    this.mealGroups =const [],
    this.blocState = BlocState.initial,
    this.message = '',
    this.notifications=const [],
    this.notice,
  });
  CmsSsrState copyWith({
    BlocState? blocState,
    String? message,
    List<SSRItemType>? mealGroups,
    List<SSRItem>? notifications,
    SharedSetting? notice,
  }) {
    return CmsSsrState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      mealGroups: mealGroups ?? this.mealGroups,
      notifications: notifications ?? this.notifications,
      notice: notice ?? this.notice,
    );
  }
  @override
  List<Object?> get props => [mealGroups, blocState, message, notice, notifications];
}

