import 'package:clean_mvvm_project/data/network/failure.dart';
import 'package:clean_mvvm_project/data/request/requests.dart';
import 'package:clean_mvvm_project/domain/repository/repository.dart';
import 'package:clean_mvvm_project/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../model/model.dart';

//UseCase is used inside viewModel
class ForgotPasswordUseCase extends BaseUseCase<String, ResetPassword> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ResetPassword>> execute(String input) async {
    return await _repository.resetPassword(ResetPasswordRequest(input));
  }
}
