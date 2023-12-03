import 'package:clean_mvvm_project/data/data_source/remote_data_source.dart';
import 'package:clean_mvvm_project/data/mapper/mapper.dart';
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
      final LoginResponse response = await _remoteDataSource.login(request);
      if (response.status == 0) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(
            409, response.message ?? 'Unknown error occurred from api.'));
      }
    } else {
      return const Left(Failure(501, 'Please check your internet connection'));
    }
  }
}
