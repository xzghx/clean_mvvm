abstract class BaseViewModel
    implements BaseViewModeInputs, BaseViewModeOutputs {}

abstract class BaseViewModeInputs {
  void start();

  void dispose();
}

abstract class BaseViewModeOutputs {}
