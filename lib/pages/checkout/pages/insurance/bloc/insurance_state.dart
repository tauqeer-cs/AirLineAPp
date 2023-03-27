part of 'insurance_cubit.dart';

class InsuranceState extends Equatable {
  final List<Passenger> passengers;
  final SummaryResponse? summaryResponse;
  final BlocState blocState;
  final String message;
  final InsuranceType? insuranceType;
  final int selectedPassenger;

  const InsuranceState({
    this.summaryResponse,
    this.passengers = const [],
    this.blocState = BlocState.initial,
    this.message = '',
    this.insuranceType,
    this.selectedPassenger= 0,
  });

  InsuranceState copyWith({
    BlocState? blocState,
    String? message,
    SummaryResponse? summaryResponse,
    List<Passenger>? passengers,
    InsuranceType? insuranceType,
    int? selectedPassenger,
  }) {
    return InsuranceState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      summaryResponse: summaryResponse ?? this.summaryResponse,
      passengers: passengers ?? this.passengers,
      insuranceType: insuranceType ?? this.insuranceType,
      selectedPassenger: selectedPassenger ?? this.selectedPassenger,

    );
  }

  @override
  List<Object?> get props => [
        summaryResponse,
        blocState,
        message,
        passengers,
        insuranceType,
    selectedPassenger,
      ];
}

enum InsuranceType {
  all,
  selected,
  none,
}
