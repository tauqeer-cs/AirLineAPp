part of 'insurance_cubit.dart';

class InsuranceState extends Equatable {
  final List<Passenger> passengers;
  final SummaryResponse? summaryResponse;
  final BlocState blocState;
  final String message;
  final InsuranceType? insuranceType;

  const InsuranceState({
    this.summaryResponse,
    this.passengers = const [],
    this.blocState = BlocState.initial,
    this.message = '',
    this.insuranceType,
  });

  InsuranceState copyWith({
    BlocState? blocState,
    String? message,
    SummaryResponse? summaryResponse,
    List<Passenger>? passengers,
    InsuranceType? insuranceType,
  }) {
    return InsuranceState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      summaryResponse: summaryResponse ?? this.summaryResponse,
      passengers: passengers ?? this.passengers,
      insuranceType: insuranceType ?? this.insuranceType,

    );
  }

  @override
  List<Object?> get props => [
        summaryResponse,
        blocState,
        message,
        passengers,
      ];
}

enum InsuranceType{
  all, selected, none,
}