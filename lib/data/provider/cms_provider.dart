import 'package:app/data/responses/home_detail.dart';
import 'package:app/data/responses/home_response.dart';
import 'package:app/data/responses/token_response.dart';
import 'package:app/models/cms_flight.dart';
import 'package:app/models/cms_route.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../responses/agent_sign_up_cms.dart';
import '../responses/common_response.dart';
import '../responses/universal_shared_settings_routes_response.dart';

part 'cms_provider.g.dart';

@RestApi()
abstract class CMSProvider {
  factory CMSProvider(Dio dio, {String baseUrl}) = _CMSProvider;

  @GET('shared/getRoute')
  Future<List<CMSRoute>> getRoutes();

  @GET('shared/get')
  Future<HomeResponse> getHomeContent(@Query("key") String key, @Query("timestamp") String timestamp, {
    @Query("query") String? query =
    "key,images,img,title,subtitle,description,image,price,link,from,to,style,titleBold,buttonText,cardSectionTitleNoBold,cardSectionTitleBold,mimg,currency",
    @Query("lang") String? lang = 'en_US',

  });

  @GET('shared/get')
  Future<CMSFlight> getSSRContent(@Query("key",) String key, {
    @Query("query") String? query = "content,image,title,description,code,banner,bannerUrl",
    @Query("deep") String? deep = "6",
    @Query("lang") String? language = "en",

  });

  @GET('shared/detail')
  Future<HomeDetail> getContentDetail(@Query("key") String key, {
    @Query("query") String? query = "content,showBookNow"
  });

  @GET('auth/gettoken')
  Future<TokenResponse> getToken();

  @GET('shared/get')
  Future<AgentSignUpCms> getAgentSignUp(@Query("key") String key, {
    @Query("query") String? query = "tnC,agreement",
    @Query("deep") String? deep = "6",

  });

  @GET('shared/get')
  Future<UniversalSharedSettingsRoutesResponse> getInsuranceName(
      @Query("key") String key, {
        @Query(
            "query") String? query = "ssrName,content,image,title,description,banner,bannerUrl,code,pdf",
        @Query("deep") String? deep = "6",
        @Query("timestamp") String? timestamp = '1650012345',
        @Query("lang") String? lang = 'en_US',

      });


}
