import 'package:clean_mvvm_project/data/network/failure.dart';
import 'package:clean_mvvm_project/data/request/requests.dart';
import 'package:clean_mvvm_project/domain/model/model.dart';
import 'package:clean_mvvm_project/domain/repository/repository.dart';
import 'package:clean_mvvm_project/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class Register implements BaseUseCase<RegisterInput, Login> {
  final Repository _repository;

  Register(this._repository);

  @override
  Future<Either<Failure, Login>> execute(input) async {
    return await _repository.register(RegisterRequest(
      userName: input.userName,
      password: input.password,
      email: input.email,
      mobile: input.mobile,
      countryCode: input.countryCode,
      profilePicture: input.profilePicture,
    ));
  }
}

class RegisterInput {
  final String userName;
  final String password;
  final String email;
  final String mobile;
  final String countryCode;
  final String profilePicture;

  RegisterInput(
      {required this.userName,
      required this.password,
      required this.email,
      required this.mobile,
      required this.countryCode,
      required this.profilePicture});
}
