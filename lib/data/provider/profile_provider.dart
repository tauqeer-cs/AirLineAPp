
import 'dart:io';

import 'package:app/data/responses/common_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/profile.dart';
import '../requests/delete_card_request.dart';
import '../requests/friend_family_add.dart';
import '../requests/update_friends_family.dart';

part 'profile_provider.g.dart';

@RestApi()
abstract class ProfileProvider {
  factory ProfileProvider(Dio dio, {String baseUrl}) = _ProfileProvider;

  @GET('user/userprofile')
  Future<Profile> getProfile();

  @POST('user/user-update')
  Future<CommonResponse> updateUserProfile(@Body() Profile profile);

  @POST('user/user-add-friendsandfamily')
  Future<CommonResponse> addFriendsFamily(@Body() FriendsFamilyAdd profile);

  @POST('user/user-update-friendsandfamily')
  Future<CommonResponse> updateFriendsFamily(@Body() UpdateFriendsFamily profile);

  @GET('user/user-delete-friendsandfamily')
  Future<CommonResponse> deleteFriendFamily(@Query("friendsandfamilyid") String key);

  @POST('user/user-delete-card')
  Future<CommonResponse> deleteUserCard(@Body() DeleteCardReuquest profile);



  @POST('user/updateprofilepicture')
  Future<CommonResponse> uploadProfilePicture(@Part() File file);



}


