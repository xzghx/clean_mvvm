import 'package:clean_mvvm_project/data/network/app_api.dart';
import 'package:clean_mvvm_project/data/request/requests.dart';

import '../response/responses.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest loginRequest);

  Future<LoginResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  const RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest loginRequest) async {
    return await _appServiceClient.resetPassword(loginRequest.email);
  }

  @override
  Future<LoginResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.email,
        registerRequest.mobile,
        registerRequest.countryCode,
        registerRequest.userName,
        registerRequest.password,
        registerRequest.profilePicture);
  }
}
