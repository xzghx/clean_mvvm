import 'package:clean_mvvm_project/data/network/error_handler.dart';

class Failure {
  final int statusCode;
  final String message;

  const Failure(this.statusCode, this.message);
}

class DefaultFailure extends Failure {
  const DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
