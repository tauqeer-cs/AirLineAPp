import 'package:app/data/repositories/profile_repository.dart';
import 'package:app/models/profile.dart';
import 'package:bloc/bloc.dart';
import 'package:app/app/app_bloc_helper.dart';
import 'package:app/utils/error_utils.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final _repository = ProfileRepository();

  resetState(){
    emit(ProfileState());
  }

  getProfile() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final routes = await _repository.getProfile();
      emit(state.copyWith(
        blocState: BlocState.finished,
        profile: routes,
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }

  Future<void> updateProfile(UserProfile userProfile) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final profile = Profile(
        userID: state.profile?.userID,
        userProfile: userProfile,
        communicationPreferences: state.profile?.communicationPreferences,
      );
      await _repository.updateProfile(profile);
      emit(state.copyWith(
        blocState: BlocState.finished,
        profile: profile,
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }

  Future<void> updatePreferences(CommunicationPreferences communicationPreferences) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final profile = Profile(
        userID: state.profile?.userID,
        userProfile: state.profile?.userProfile,
        communicationPreferences: communicationPreferences,
      );
      await _repository.updateProfile(profile);
      emit(state.copyWith(
        blocState: BlocState.finished,
        profile: profile,
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }

  /*Profile setTmpObject(
    String? icNumber,
    String? newTitle,
    String? newFirstName,
    String? lastName,
    String? newCountry,
    String? newEmail,
    DateTime? newDob,
    String? newPhoneCountryCode,
    String? newPhNo,
    String? newAddress,
    String? newAddressCountry,
    String? newAddressState,
    String? newAddressCity,
    String? newAddresZipCode,
    String? emergencyFirstName,
    String? emergencyLastName,
    String? emergencyRelationShip,
    String? emergencyPhCode,
    String? emergencyPhNo,
  ) {
    var copyProfile = state.profile;
    if (newTitle != null) {
      copyProfile?.userProfile?.title = newTitle;
    }

    if (newFirstName != null) {
      copyProfile?.userProfile?.firstName = newFirstName;
    }

    if (lastName != null) {
      copyProfile?.userProfile?.lastName = lastName;
    }

    if (newCountry != null) {
      copyProfile?.userProfile?.country = newCountry;
    }

    if (icNumber != null) {
      copyProfile?.userProfile?.icNumber = icNumber;
    }

    if (newEmail != null) {
      copyProfile?.userProfile?.email = newEmail;
    }

    if (newDob != null) {
      copyProfile?.userProfile?.dob = newDob;
    }

    if (newPhoneCountryCode != null) {
      copyProfile?.userProfile?.phoneCode = newPhoneCountryCode;
    }

    if (newPhNo != null) {
      copyProfile?.userProfile?.phoneNumber = newPhNo;
    }

    if (newPhNo != null) {
      copyProfile?.userProfile?.phoneNumber = newPhNo;
    }

    if (newAddress != null) {
      copyProfile?.userProfile?.address = newAddress;
    }

    if (newAddressCountry != null) {
      copyProfile?.userProfile?.country = newAddressCountry;
    }

    if (newAddressState != null) {
      copyProfile?.userProfile?.state = newAddressState;
    }

    if (newAddressCity != null) {
      copyProfile?.userProfile?.city = newAddressCity;
    }

    if (newAddresZipCode != null) {
      copyProfile?.userProfile?.postCode = newAddresZipCode;
    }

    if (emergencyFirstName != null) {
      copyProfile?.userProfile?.emergencyContact?.firstName =
          emergencyFirstName;
    }

    if (emergencyLastName != null) {
      copyProfile?.userProfile?.emergencyContact?.lastName = emergencyLastName;
    }

    if (emergencyRelationShip != null) {
      copyProfile?.userProfile?.emergencyContact?.relationship =
          emergencyRelationShip;
    }
    if (emergencyPhCode != null) {
      copyProfile?.userProfile?.emergencyContact?.phoneCode = emergencyPhCode;
    }
    if (emergencyPhNo != null) {
      copyProfile?.userProfile?.emergencyContact?.phoneNumber = emergencyPhNo;
    }
    return copyProfile!;
  }*/
}
