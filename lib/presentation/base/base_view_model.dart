import 'dart:async';

import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {
  final StreamController<FlowState> _flowStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputFlowState => _flowStateStreamController.sink;

  @override
  Stream<FlowState> get outputFlowState =>
      _flowStateStreamController.stream.map((FlowState flowState) => flowState);

  @override
  void dispose() {
    _flowStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  Sink get inputFlowState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputFlowState;
}
