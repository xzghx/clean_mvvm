import 'package:dartz/dartz.dart';

import '../data/network/failure.dart';
import '../data/request/requests.dart';
import '../data/response/responses.dart';

abstract class Repository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
}
