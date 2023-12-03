import 'package:dartz/dartz.dart';

import '../data/network/failure.dart';
import '../data/request/requests.dart';
import 'model.dart';

abstract class Repository {
  Future<Either<Failure, Login>> login(LoginRequest request);
}
