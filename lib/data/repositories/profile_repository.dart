import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/profile_provider.dart';
import 'package:app/data/provider/public_provider.dart';
import 'package:app/models/country.dart';

import '../../models/profile.dart';

class ProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._internal();

  static final  _provider = ProfileProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  ProfileRepository._internal();



  factory ProfileRepository() {
    return _instance;
  }


  Future<Profile> getProfile() async {
    return await _provider.getProfile();
  }

}