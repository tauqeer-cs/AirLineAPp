import 'package:app/models/country.dart';
import 'package:app/models/switch_setting.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'public_provider.g.dart';

@RestApi()
abstract class PublicProvider {
  factory PublicProvider(Dio dio, {String baseUrl}) = _PublicProvider;

  @GET('public/getcountry')
  Future<Countries> getCountries();

  @GET('public/getswitchsetting')
  Future<SwitchSetting> getSettings();

  @GET('public/getmalaysiastate')
  Future<StateResult> getStates();

  //StatesApiResponse
}
