import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_prefs.dart';
import '../../app/links.dart';

const String CONTENT_TYPE = 'content-type';
const String APPLICATION_JSON = 'application/json';
const String ACCEPT = 'accept';
const String DEFAULT_LANGUAGE = 'language';
const String AUTHORIZATION = 'authorization';

class DioFactory {
  final AppPrefs _appPrefs;

  const DioFactory(this._appPrefs);

  getDio() {
    Dio dio = Dio();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      DEFAULT_LANGUAGE: _appPrefs.getLanguage(),
      AUTHORIZATION: Links.token
    };
    dio.options = BaseOptions(
      baseUrl: Links.baseurl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: headers,
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    return dio;
  }
}
