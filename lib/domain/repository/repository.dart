import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/request/requests.dart';
import '../model/model.dart';

abstract class Repository {
  Future<Either<Failure, Login>> login(LoginRequest request);

  Future<Either<Failure, ResetPassword>> resetPassword(
      ResetPasswordRequest request);

  Future<Either<Failure, Login>> register(RegisterRequest request);
}
