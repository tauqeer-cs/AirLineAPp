part of 'cms_ssr_cubit.dart';

class CmsSsrState extends Equatable {
  final List<SSRItemType> mealGroups;
  final List<SSRItemType> bundleGroups;
  final List<SSRItem>? notifications;
  final String? language;

  final SharedSetting? notice;
  final SharedSetting? bundleNotice;
  final SharedSetting? seatNotice;
  final SharedSetting? oversizedNotice;
  final SharedSetting? carryNotice;
  final BlocState blocState;
  final String message;
  final String? checkInLabel;
  final String? manageBookLabel;

  const CmsSsrState(this.language,  {
    this.bundleGroups = const [],
    this.mealGroups = const [],
    this.blocState = BlocState.initial,
    this.message = '',
    this.notifications = const [],
    this.notice,
    this.bundleNotice,
    this.seatNotice,
    this.oversizedNotice,
    this.carryNotice,
    this.checkInLabel,
    this.manageBookLabel
  });

  CmsSsrState copyWith({
    BlocState? blocState,
    String? message,
    List<SSRItemType>? mealGroups,
    List<SSRItemType>? bundleGroups,
    List<SSRItem>? notifications,
    SharedSetting? notice,
    SharedSetting? bundleNotice,
    SharedSetting? seatNotice,
    SharedSetting? oversizedNotice,
    SharedSetting? carryNotice,
    String? checkInLabel,
    String? manageBookLabel
  }) {
    return CmsSsrState(
      language,
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      mealGroups: mealGroups ?? this.mealGroups,
      bundleGroups: bundleGroups ?? this.bundleGroups,
      notifications: notifications ?? this.notifications,
      notice: notice ?? this.notice,
      bundleNotice: bundleNotice ?? this.bundleNotice,
      seatNotice: seatNotice ?? this.seatNotice,
      oversizedNotice: oversizedNotice ?? this.oversizedNotice,
      carryNotice: carryNotice ?? this.carryNotice,
        checkInLabel : checkInLabel ?? this.checkInLabel,
        manageBookLabel : manageBookLabel ?? this.manageBookLabel
    );
  }

  @override
  List<Object?> get props => [
        mealGroups,
        blocState,
        message,
        notice,
        notifications,
        bundleNotice,
        seatNotice,
        oversizedNotice,
        carryNotice,
      language,
    checkInLabel,
    manageBookLabel
      ];
}
