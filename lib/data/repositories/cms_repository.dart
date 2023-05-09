
import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/cms_provider.dart';
import 'package:app/data/responses/home_detail.dart';
import 'package:app/data/responses/home_response.dart';
import 'package:app/models/cms_flight.dart';
import 'package:app/models/cms_route.dart';

import '../responses/agent_sign_up_cms.dart';
import '../responses/universal_shared_settings_routes_response.dart';

class CMSRepository {

  static final CMSRepository _instance = CMSRepository._internal();

  static final CMSProvider _provider = CMSProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlCMS}/umbraco/',
  );

  factory CMSRepository() {
    return _instance;
  }

  String? cmsToken;
  DateTime lastFetchToken = DateTime.now();

  CMSRepository._internal();

  Future<dynamic> getCMSToken() async {
    //final nextExpired = lastFetchToken.add(Duration(hours: 1));
    //if (cmsToken == null || nextExpired.isBefore(DateTime.now())) {
      final token = await _provider.getToken();
      lastFetchToken = DateTime.now();
      cmsToken = token.token;
    //}
  }

  Future<List<CMSRoute>> getRoutes() async {
    await getCMSToken();
    return await _provider.getRoutes();
  }

  Future<HomeResponse> getHomeContent(String id,String language) async {
    DateTime now = DateTime.now();
    int unixTimestamp = now.millisecondsSinceEpoch ~/ 1000; // dividing by 1000 to get seconds instead of milliseconds
    String unixTimestampString = unixTimestamp.toString();


    await getCMSToken();
    return await _provider.getHomeContent(id, DateTime.now().millisecondsSinceEpoch.toString(),lang: language == 'th' ? 'th-TH' : 'en-US');
  }

  Future<CMSFlight> getSSRContent(String id,String language) async {
    await getCMSToken();
    return await _provider.getSSRContent(id,language: language == 'th' ? 'th-TH' : 'en-US');
  }

  Future<HomeDetail> getContentDetail(String id) async {
    await getCMSToken();
    return await _provider.getContentDetail(id);
  }

  Future<AgentSignUpCms> agentSignUp(String id,String language) async {
    await getCMSToken();
    return await _provider.getAgentSignUp(id);
  }

  Future<UniversalSharedSettingsRoutesResponse> agenInsurance(String id,String language) async {
    DateTime now = DateTime.now();
    int unixTimestamp = now.millisecondsSinceEpoch ~/ 1000; // dividing by 1000 to get seconds instead of milliseconds
    String unixTimestampString = unixTimestamp.toString();

    await getCMSToken();
    return await _provider.getInsuranceName(id,timestamp: DateTime.now().millisecondsSinceEpoch.toString(),lang: language == 'th' ? 'th-TH' : 'en-US');
  }

}
