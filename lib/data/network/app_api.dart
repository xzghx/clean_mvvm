import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../app/links.dart';
import '../response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Links.baseurl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String? baseUrl}) = _AppServiceClient;

  @POST('/v3/161a2ee5-4007-4c72-9d96-1e7d9cc25eaa')
  Future<LoginResponse> login(
    @Field('email') String email,
    @Field('password') String password,
    @Field('imei') String imei,
    @Field('deviceType') String deviceType,
  );

  @POST('/v3/379667ef-d280-418a-b62d-d8fb682b4d80')
  Future<ResetPasswordResponse> resetPassword(
    @Field('email') String email,
  );
}
