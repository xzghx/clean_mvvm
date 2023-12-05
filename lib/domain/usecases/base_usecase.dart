//usecase is a bridge for viewModel and outside
//In is passed from viewModel to usecase ex for login, we pass username,password as In
//and Out is the result of api call for login
import 'package:clean_mvvm_project/data/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
