part of 'insurance_cubit.dart';

class InsuranceState extends Equatable {
  final List<Passenger> passengers;

  List<Passenger> get passengersWithOutInfants {


    return passengers.where((element) => element.paxType != 'INF').toList();

  }
  final SummaryResponse? summaryResponse;
  final BlocState blocState;
  final String message;
  final InsuranceType? insuranceType;
  final int selectedPassenger;
  final Bundle? lastInsuranceSelected;

  const InsuranceState({
    this.summaryResponse,
    this.passengers = const [],
    this.blocState = BlocState.initial,
    this.message = '',
    this.insuranceType,
    this.selectedPassenger = 0,
    this.lastInsuranceSelected,
  });

  InsuranceState copyWith({
    BlocState? blocState,
    String? message,
    SummaryResponse? summaryResponse,
    List<Passenger>? passengers,
    InsuranceType? insuranceType,
    int? selectedPassenger,
    Bundle? lastInsuranceSelected,
  }) {
    return InsuranceState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      summaryResponse: summaryResponse ?? this.summaryResponse,
      passengers: passengers ?? this.passengers,
      insuranceType: insuranceType ?? this.insuranceType,
      selectedPassenger: selectedPassenger ?? this.selectedPassenger,
      lastInsuranceSelected:
          lastInsuranceSelected ?? this.lastInsuranceSelected,
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
        lastInsuranceSelected
      ];

  double totalInsurance() {
    double totalInsurance = 0;
    for (var element in passengersWithOutInfants) {
      totalInsurance = totalInsurance + (element.getInsurance?.price ?? 0);
    }
    return totalInsurance;
  }
}

enum InsuranceType {
  all,
  selected,
  none,
}
