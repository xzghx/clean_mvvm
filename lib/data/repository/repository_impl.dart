import 'package:clean_mvvm_project/data/data_source/remote_data_source.dart';
import 'package:clean_mvvm_project/data/mapper/mapper.dart';
import 'package:clean_mvvm_project/data/network/error_handler.dart';
import 'package:clean_mvvm_project/data/network/failure.dart';
import 'package:clean_mvvm_project/data/network/network_info.dart';
import 'package:clean_mvvm_project/data/request/requests.dart';
import 'package:clean_mvvm_project/data/response/responses.dart';
import 'package:clean_mvvm_project/domain/repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/model.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Login>> login(LoginRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final LoginResponse response = await _remoteDataSource.login(request);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
