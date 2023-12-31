import 'package:app/data/repositories/profile_repository.dart';
import 'package:app/data/requests/friend_family_add.dart';
import 'package:app/models/profile.dart';
import 'package:bloc/bloc.dart';
import 'package:app/app/app_bloc_helper.dart';
import 'package:app/utils/error_utils.dart';
import 'package:equatable/equatable.dart';

import '../../data/requests/delete_card_request.dart';
import '../../data/requests/update_friends_family.dart';
import '../../models/number_person.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final _repository = ProfileRepository();

  resetState() {
    emit(const ProfileState());
  }

  List<FriendsFamily> friendFamily(Person person,DateTime departureDate,PeopleType type) {
    if (state.profile?.userProfile?.friendsAndFamily != null) {

      //person.
      var limitDate = person.dateLimitStart(departureDate);

      var check = state.profile!.userProfile!.friendsAndFamily!.where((element) => element.dobDate!.difference(limitDate).inDays > 1).toList();

      if(type == PeopleType.adult) {
       return check.where((ff) {
          DateTime? dob = ff.dobDate;
          if (dob == null) {
            return false;
          }
          DateTime now = DateTime.now();
          DateTime twelveYearsAgo = DateTime(now.year - 12, now.month, now.day);
          return dob.isBefore(twelveYearsAgo);
        }).toList();
      }
      else if(type == PeopleType.child){

        return check.where((ff) {
          DateTime? dob = ff.dobDate;
          if (dob == null) {
            return false;
          }
          DateTime now = DateTime.now();
          DateTime twoYearsAgo = DateTime(now.year - 2, now.month, now.day);
          DateTime twelveYearsAgo = DateTime(now.year - 12, now.month, now.day);
          return dob.isAfter(twelveYearsAgo) && dob.isBefore(twoYearsAgo);
        }).toList();

      }
      else if(type == PeopleType.infant){
        return check.where((ff) {
          DateTime? dob = ff.dobDate;
          if (dob == null) {
            return false;
          }
          DateTime now = DateTime.now();
          DateTime twoYearsAgo = DateTime(now.year - 2, now.month, now.day);
          return dob.isAfter(twoYearsAgo);
        }).toList();
      }
      return check;
    }
    return [];
  }

  bool get hasAnyFriends {
    if (state.profile != null) {
      return true;
    }
    return false;
  }

  void deleteCard(int cardIndex) async {
    emit(
      state.copyWith(deletingCard: true),
    );

    try {
      //
      var requestObject = DeleteCardReuquest(
        expiryDate: state.profile!.userProfile!.memberCards![cardIndex].expiryDate,
        countryCode: state.profile!.userProfile!.memberCards![cardIndex].countryCode,
        token: state.profile!.userProfile!.memberCards![cardIndex].token,
      );

      final response = await _repository.deleteUserCard(requestObject);
      final routes = await _repository.getProfile();
      emit(state.copyWith(profile: routes, deletingCard: false));
    } catch (e, st) {
      emit(state.copyWith(
        deletingCard: false,
      ));
    }
  }
  void deleteFnF(String id) async {
    emit(
      state.copyWith(deletingId: id, deletedFnf: true),
    );

    try {
      final response = await _repository.deleteFamilyFriend(id);
      final routes = await _repository.getProfile();
      emit(state.copyWith(profile: routes, deletedFnf: false));
    } catch (e, st) {
      emit(state.copyWith(
        deletedFnf: false,
      ));
    }
  }

  void editFamilyMember(UpdateFriendsFamily member) async {
    emit(
      state.copyWith(
        updatingFnF: true,
        deletingId: member.friendsAndFamilyID.toString(),
      ),
    );

    try {
      final response = await _repository.updateFriendsAndFamily(member);

      if (response.success == false) {
        emit(
          state.copyWith(
              blocState: BlocState.failed,
              updatingFnF: false,
              message: response.message),
        );
        return;
      }

      final routes = await _repository.getProfile();
      emit(state.copyWith(
        profile: routes,
        updatingFnF: false,
        blocState: BlocState.finished,
      ));
    } catch (e, st) {
      emit(state.copyWith(
          blocState: BlocState.finished,
          updatingFnF: false,
          errorWhileAddingFnf: true));
    }
  }

  void addFamilyMember(FriendsFamilyAdd member) async {
    emit(state.copyWith(addingFnF: true));

    try {
      final response = await _repository.addFriendsAndFamily(member);
      if (response.success == false) {
        emit(state.copyWith(
            blocState: BlocState.failed,
            addingFnF: false,
            message: response.message));
        return;
      }

      final routes = await _repository.getProfile();
      emit(state.copyWith(
        profile: routes,
        addingFnF: false,
        blocState: BlocState.finished,
      ));
    } catch (e, st) {
      emit(state.copyWith(
          blocState: BlocState.finished,
          addingFnF: false,
          errorWhileAddingFnf: true));
    }
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

  Future<void> updatePreferences(
      CommunicationPreferences communicationPreferences) async {
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


}
