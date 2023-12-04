import 'package:clean_mvvm_project/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  AUNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  BAD_CERT,
  BAD_RESPOSNSE,
  DEFAULT,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      //error is from dio
      failure = _handleError(error);
    } else {
      //default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();

      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();

      case DioExceptionType.badCertificate:
        return DataSource.BAD_CERT.getFailure();

      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }

      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioExceptionType.connectionError:
        return DataSource.CONNECT_TIMEOUT.getFailure();

      case DioExceptionType.unknown:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      //These two cases are not Failures
      //case DataSource.SUCCESS:
      //
      //       case DataSource.NO_CONTENT:
      //
      case DataSource.BAD_REQUEST:
        return const Failure(
            ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return const Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.AUNAUTHORISED:
        return const Failure(
            ResponseCode.AUNAUTHORISED, ResponseMessage.AUNAUTHORISED);

      case DataSource.NOT_FOUND:
        return const Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return const Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return const Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return const Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECEIVE_TIMEOUT:
        return const Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return const Failure(
            ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return const Failure(
            ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return const Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.BAD_CERT:
        return const Failure(ResponseCode.BAD_CERT, ResponseMessage.BAD_CERT);

      case DataSource.DEFAULT:
        return const Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);

      default:
        return const Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  //Api status codes
  static const int SUCCESS = 200; //success with data
  static const int NO_CONTENT = 201; // success with no data
  static const int BAD_REQUEST = 400; //failure, api rejected the request
  static const int FORBIDDEN = 403; //failure, api rejected the request
  static const int AUNAUTHORISED = 401; //failure user is not authorized
  static const int NOT_FOUND = 404; // failure, url not correct, or not found
  static const int INTERNAL_SERVER_ERROR = 500; //failure , crash in server

  //Local status codes
  static const int BAD_CERT = 495;
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  //Api status codes
  static const String SUCCESS = 'success'; //success with data
  static const String NO_CONTENT =
      'success with no data'; // success with no data
  static const String BAD_REQUEST = 'failure, api rejected the request'; //fail
  static const String BAD_CERT = 'Certificate not valid';

  /// ure, api rejected the request
  static const String FORBIDDEN =
      'failure, content is forbidden'; //failure, api rejected the request
  static const String AUNAUTHORISED =
      'failure, user is not authorized'; //failure user is not authorized
  static const String NOT_FOUND =
      'failure, url not correct, or not found'; // failure, url not correct, or not found
  static const String INTERNAL_SERVER_ERROR =
      'Internal server error, please try later'; //failure , crash in server

  //Local status codes
  static const String DEFAULT = 'Something went wrong, try later';
  static const String CONNECT_TIMEOUT = 'connection time out error';
  static const String CANCEL = 'request was canceled';
  static const String RECEIVE_TIMEOUT =
      'connection time out error in receiving data';
  static const String SEND_TIMEOUT =
      'connection time out error in sending data';
  static const String CACHE_ERROR = 'cache error, try later';
  static const String NO_INTERNET_CONNECTION =
      'internet not connected, please check the connection.';
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = -1;
}
