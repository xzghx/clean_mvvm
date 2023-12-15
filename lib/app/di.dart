import 'package:clean_mvvm_project/app/app_prefs.dart';
import 'package:clean_mvvm_project/data/network/app_api.dart';
import 'package:clean_mvvm_project/data/network/dio_factory.dart';
import 'package:clean_mvvm_project/data/repository/repository_impl.dart';
import 'package:clean_mvvm_project/domain/usecases/forgot_password_usecase.dart';
import 'package:clean_mvvm_project/domain/usecases/login_usecase.dart';
import 'package:clean_mvvm_project/presentation/forgot_password/forgot_password_viewModel.dart';
import 'package:clean_mvvm_project/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/network_info.dart';
import '../domain/repository/repository.dart';

final instance = GetIt.instance;

initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  //register sharedPrefs
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  //register AppPrefs  ** since we have registered SharedPreferences, so instance() will automatically return sharedPrefs.
  instance.registerLazySingleton<AppPrefs>(() => AppPrefs(instance()));
  //register networkInfo
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  //register dioFactory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  //register appServiceClient
  instance.registerLazySingleton<AppServiceClient>(
      () => AppServiceClient(instance<DioFactory>().getDio()));
  //register remoteDataSource
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));
  //register repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

//this should be initialized when login page is opened.
void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    //** registerFactory will create a new instance of LoginUseCase every time that is being called.
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    //register LoginViewModel
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

void initResetPasswordModule() {
  instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance()));
  instance.registerFactory<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel(instance()));
}
