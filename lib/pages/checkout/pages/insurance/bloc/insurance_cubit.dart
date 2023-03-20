import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/responses/summary_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'insurance_state.dart';

class InsuranceCubit extends Cubit<InsuranceState> {
  InsuranceCubit() : super(InsuranceState());

  updateInsuranceToPassenger(int index, Bound? insurance) {
    final newPassenger = state.passengers[index].copyWith(
      ssr: Ssr(outbound: insurance == null ? [] : [insurance]),
    );
    final newList = List<Passenger>.from(state.passengers);
    newList.removeAt(index);
    newList.insert(index, newPassenger);
    emit(state.copyWith(
      passengers: newList,
      insuranceType: InsuranceType.selected,
    ));
  }

  updateInsuranceToAllPassenger(Bound? insurance) {
    final newList = List<Passenger>.from([]);
    for (var element in state.passengers) {
      final newPassenger = element.copyWith(
        ssr: Ssr(outbound: insurance == null ? [] : [insurance]),
      );
      newList.add(newPassenger);
    }
    emit(state.copyWith(
      passengers: newList,
      insuranceType: InsuranceType.selected,
    ));
  }

  removeInsurance(Bound? insurance) {
    final newList = List<Passenger>.from([]);
    for (var element in state.passengers) {
      final newPassenger = element.copyWith(
        ssr: const Ssr(outbound: []),
      );
      newList.add(newPassenger);
    }
    emit(state.copyWith(
      passengers: newList,
      insuranceType: InsuranceType.none,
    ));
  }
}
