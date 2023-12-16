import 'dart:async';

import 'package:clean_mvvm_project/domain/usecases/forgot_password_usecase.dart';
import 'package:clean_mvvm_project/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_mvvm_project/presentation/common/state_renderer/state_renderer_impl.dart';

import '../base/base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInput, ForgotPasswordViewModelOutPut {
  String _email = '';
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final StreamController<String> _emailStController =
      StreamController<String>.broadcast();

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  //inputs
  @override
  void emailChanged(String value) {
    _email = value;
    emailSink.add(value);
  }

  @override
  void start() {
    inputFlowState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStController.close();
  }

  @override
  void resetPassword() async {
    inputFlowState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgotPasswordUseCase.execute(_email)).fold((l) {
      inputFlowState.add(ErrorState(
          message: l.message,
          stateRendererType: StateRendererType.popupErrorState));
    }, (r) {
      inputFlowState.add(SuccessState(
        message: r.supportMessage,
      ));
    });
  }

  //OutPuts

  @override
  Sink get emailSink => _emailStController.sink;

  @override
  Stream<bool> get isEmailValid => _emailStController.stream
      .map((v) => _email.length >= 4 && _email.contains('@'));

//Functions
}

abstract class ForgotPasswordViewModelInput {
  void emailChanged(String value);

  Sink get emailSink;

  void resetPassword();
}

abstract class ForgotPasswordViewModelOutPut {
  Stream<bool> get isEmailValid;
}
