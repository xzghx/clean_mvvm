import 'dart:async';

import 'package:clean_mvvm_project/domain/usecases/login_usecase.dart';
import 'package:clean_mvvm_project/presentation/base/base_view_model.dart';
import 'package:clean_mvvm_project/presentation/common/freezed_data_classes.dart';
import 'package:clean_mvvm_project/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_mvvm_project/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController<String> _userNameStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _isAllValidStreamController =
      StreamController<void>.broadcast();
  final StreamController<bool> isLoggedInSController = StreamController<bool>();

  LoginObject loginObject = LoginObject('', '');
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  //from base---------------------
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllValidStreamController.close();
    isLoggedInSController.close();
  }

  @override
  void start() {
    //Show the login ui at the start
    inputFlowState.add(ContentState());
  }

  //Inputs---------------------
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllValid => _isAllValidStreamController.sink;

  @override
  void login() async {
    inputFlowState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
      (failure) => {
        //left , failure
        // print(failure.message);
        inputFlowState.add(ErrorState(
            message: failure.message,
            stateRendererType: StateRendererType.popupErrorState))
      },
      (data) {
        //right , data
        // print(data.customer.name);
        inputFlowState.add(ContentState());
        isLoggedInSController.add(true);
      },
    );
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validateForm();
  }

  @override
  void setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validateForm();
  }

  _validateForm() {
    // add event to sink to validate all inputs
    inputIsAllValid.add(null);
  }

  //outPuts---------------------
  @override
  Stream<bool> get outPutIsPasswordValid => _passwordStreamController.stream
      .map((String password) => _isPasswordValid(password));

  @override
  Stream<bool> get outPutIsUserNameValid => _userNameStreamController.stream
      .map((String username) => _isUserNameValid(username));

  @override
  Stream<bool> get outPutIsAllValid =>
      _isAllValidStreamController.stream.map((event) => _isAllValid());

  //Private Functions
  _isPasswordValid(String password) {
    return password.isNotEmpty && password.length >= 3;
  }

  _isUserNameValid(String username) {
    return username.isNotEmpty && username.length >= 3;
  }

  _isAllValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  void setUserName(String userName);

  void setPassword(String password);

  void login();

  Sink get inputPassword;

  Sink get inputUserName;

  Sink get inputIsAllValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outPutIsPasswordValid;

  Stream<bool> get outPutIsUserNameValid;

  Stream<bool> get outPutIsAllValid;
}
