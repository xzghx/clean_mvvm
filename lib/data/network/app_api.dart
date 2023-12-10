import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../app/links.dart';
import '../response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Links.baseurl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String? baseUrl}) = _AppServiceClient;

  @POST('/v3/f0fb3ca9-85f2-4811-92b8-352861602d1e')
  Future<LoginResponse> login(
    @Field('email') String email,
    @Field('password') String password,
    @Field('imei') String imei,
    @Field('deviceType') String deviceType,
  );
}
