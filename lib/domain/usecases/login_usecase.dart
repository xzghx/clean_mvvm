import 'package:clean_mvvm_project/app/functions.dart';
import 'package:clean_mvvm_project/data/network/failure.dart';
import 'package:clean_mvvm_project/data/request/requests.dart';
import 'package:clean_mvvm_project/domain/model/model.dart';
import 'package:clean_mvvm_project/domain/repository/repository.dart';
import 'package:clean_mvvm_project/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Login> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Login>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceInfo();
    return await _repository.login(LoginRequest(
        input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }
}

class LoginUseCaseInput {
  final String email;

  final String password;

  LoginUseCaseInput(this.email, this.password);
}
