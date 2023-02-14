import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/profile_provider.dart';
import 'package:app/data/repositories/insider_repository.dart';
import 'package:app/data/responses/common_response.dart';

import '../../models/profile.dart';
import '../requests/delete_card_request.dart';
import '../requests/friend_family_add.dart';
import '../requests/update_friends_family.dart';

class ProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._internal();
  final InsiderRepository insiderRepository = InsiderRepository();

  static final  _provider = ProfileProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  ProfileRepository._internal();



  factory ProfileRepository() {
    return _instance;
  }


  Future<Profile> getProfile() async {
    final profile = await _provider.getProfile();
    if(profile.userProfile!=null){
      insiderRepository.loginProfile(profile.userProfile!);
    }
    return profile;
  }

  Future<CommonResponse> updateProfile(Profile profile) async {
    return await _provider.updateUserProfile(profile);
  }

  Future<CommonResponse> addFriendsAndFamily(FriendsFamilyAdd familyMember) async {
    return await _provider.addFriendsFamily(familyMember);
  }
  Future<CommonResponse> updateFriendsAndFamily(UpdateFriendsFamily familyMember) async {
    return await _provider.updateFriendsFamily(familyMember);
  }

  Future<CommonResponse> deleteFamilyFriend(String familyMemberId) async {
    return await _provider.deleteFriendFamily(familyMemberId);
  }

  Future<CommonResponse> deleteUserCard(DeleteCardReuquest card) async {
    return await _provider.deleteUserCard(card);
  }

  //


  //
  //

}