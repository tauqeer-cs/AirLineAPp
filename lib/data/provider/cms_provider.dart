import 'package:app/data/responses/airports_response.dart';
import 'package:app/data/responses/home_response.dart';
import 'package:app/data/responses/token_response.dart';
import 'package:app/models/airports.dart';
import 'package:app/models/cms_flight.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/models/home_content.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cms_provider.g.dart';

@RestApi()
abstract class CMSProvider {
  factory CMSProvider(Dio dio, {String baseUrl}) = _CMSProvider;

  @GET('shared/getRoute')
  Future<List<CMSRoute>> getRoutes();

  @GET('shared/get')
  Future<HomeResponse> getHomeContent(
    @Query("key") String key, {
    @Query("query") String? query =
        "images,img,title,subtitle,description,image,price,link,style,titleBold,buttonText,cardSectionTitleNoBold,cardSectionTitleBold",
  });

  @GET('shared/get')
  Future<CMSFlight> getSSRContent(
      @Query("key") String key, {
        @Query("query") String? query =
        "code,image",
      });

  @GET('auth/gettoken')
  Future<TokenResponse> getToken();
}
