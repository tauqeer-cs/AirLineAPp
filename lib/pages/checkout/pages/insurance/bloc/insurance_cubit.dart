import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/responses/summary_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../utils/constant_utils.dart';

part 'insurance_state.dart';

class InsuranceCubit extends Cubit<InsuranceState> {
  InsuranceCubit() : super(InsuranceState());

  init(List<Passenger> passengers) {
    emit(state.copyWith(
      passengers: passengers,
    ));
  }

  selectPassenger(int index) {
    emit(state.copyWith(selectedPassenger: index));
  }

  changeInsuranceType(InsuranceType insuranceType, Bound? insurance) {
    if (insuranceType == state.insuranceType) return;
    switch (insuranceType) {
      case InsuranceType.all:
        updateInsuranceToAllPassenger(insurance);
        break;
      case InsuranceType.selected:
        final newList = List<Passenger>.from([]);
        for (var element in state.passengers) {
          final newPassenger = element.copyWith(
            ssr: const Ssr(outbound: []),
          );
          newList.add(newPassenger);
        }
        emit(state.copyWith(
          passengers: newList,
          insuranceType: InsuranceType.selected,
        ));
        break;
      case InsuranceType.none:
        removeAllInsurance(insurance);
        break;
    }
  }

  updateInsuranceToPassenger(int index, Bound? insurance, String? codeType) {
    final newList = List<Passenger>.from(state.passengers);
    // insurance
    //insurance.name = 'Insurance (One Way)';
   /* insurance = Bound(
        name: 'Insurance (One Way)',
        logicalFlightId: insurance?.logicalFlightId,
        price: insurance?.price,
        quantity: 1,
        servicesType: 'Insurance',
        ssrCode: insurance?.ssrCode);*/


    //
    if (insurance != null) {
      insurance = insurance.copyWith(code: codeType,
      //    name: 'Insurance (One Way)'
      );
    }
    final newPassenger = newList[index].copyWith(
      ssr: Ssr(outbound: insurance == null ? [] : [insurance]),
    );
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
    print("update to all");
    emit(state.copyWith(
      passengers: newList,
      insuranceType: InsuranceType.all,
    ));
  }

  removeAllInsurance(Bound? insurance) {
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

  void setLast(Bundle? firstWhereOrNull) {
    if (firstWhereOrNull != null) {
      emit(state.copyWith(
        lastInsuranceSelected: firstWhereOrNull,
      ));
    }
  }

  void resetStates() {

    emit(state.copyWithNull(
        insuranceType : true,
      selectedPassenger:  true,

    ));
  }
}
