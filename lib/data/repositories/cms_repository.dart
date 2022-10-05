
import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/cms_provider.dart';
import 'package:app/data/provider/flight_provider.dart';
import 'package:app/data/responses/airports_response.dart';
import 'package:app/data/responses/home_response.dart';
import 'package:app/models/cms_flight.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/models/home_content.dart';

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

  CMSRepository._internal();

  Future<dynamic> getCMSToken() async {
    //if (cmsToken == null) {
      final token = await _provider.getToken();
      cmsToken = token.token;
    //}
  }

  Future<List<CMSRoute>> getRoutes() async {
    return await _provider.getRoutes();
  }

  Future<HomeResponse> getHomeContent(String id) async {
    await getCMSToken();
    return await _provider.getHomeContent(id);
  }

  Future<CMSFlight> getSSRContent(String id) async {
    await getCMSToken();
    return await _provider.getSSRContent(id);
  }
}
