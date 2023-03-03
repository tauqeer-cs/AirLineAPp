import 'package:app/data/responses/home_detail.dart';
import 'package:app/data/responses/home_response.dart';
import 'package:app/data/responses/token_response.dart';
import 'package:app/models/cms_flight.dart';
import 'package:app/models/cms_route.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cms_provider.g.dart';

@RestApi()
abstract class CMSProvider {
  factory CMSProvider(Dio dio, {String baseUrl}) = _CMSProvider;

  @GET('shared/getRoute')
  Future<List<CMSRoute>> getRoutes();

  @GET('shared/get')
  Future<HomeResponse> getHomeContent(@Query("key") String key, {
    @Query("query") String? query =
    "key,images,img,title,subtitle,description,image,price,link,from,to,style,titleBold,buttonText,cardSectionTitleNoBold,cardSectionTitleBold,mimg",
  });

  @GET('shared/get')
  Future<CMSFlight> getSSRContent(@Query("key") String key, {
    @Query("query") String? query = "content,image,title,description,code",
    @Query("deep") String? deep = "6",
  });

  @GET('shared/detail')
  Future<HomeDetail> getContentDetail(@Query("key") String key, {
    @Query("query") String? query = "content,showBookNow"
  });

  @GET('auth/gettoken')
  Future<TokenResponse> getToken();
}
