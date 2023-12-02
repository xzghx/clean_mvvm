import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../app/links.dart';
import '../response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Links.baseurl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String? baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<LoginResponse> login();
}
