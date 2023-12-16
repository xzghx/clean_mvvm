import 'package:clean_mvvm_project/data/mapper/mapper.dart';
import 'package:clean_mvvm_project/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

abstract class FlowState {
  String getMessage();

  StateRendererType getStateRendererType();
}

//Loading state( Full screen , popup)
class LoadingState implements FlowState {
  final String message;
  final StateRendererType stateRendererType;

  LoadingState(
      {this.message = AppStrings.loading, required this.stateRendererType});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Loading state( Full screen , popup)
class ErrorState implements FlowState {
  final String message;
  final StateRendererType stateRendererType;

  ErrorState({required this.message, required this.stateRendererType});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Success State
class SuccessState implements FlowState {
  final String message;

  SuccessState({required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupSuccessState;
}

//Content state( received data with no error, no  loading)
class ContentState extends FlowState {
  ContentState();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;

  @override
  String getMessage() => EMPTY;
}

//Content state( received data with no error, no  loading)
class EmptyState extends FlowState {
  final String message;

  EmptyState(this.message);

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;

  @override
  String getMessage() => message;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      void Function() retryFunc) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          //show popup
          _showPopup(context, getMessage(), getStateRendererType(), retryFunc);
          return contentScreenWidget;
        } else //StateRendererType.fullScreenLoadingState
        {
          return StateRenderer(
            type: getStateRendererType(),
            retryAction: retryFunc,
            message: getMessage(),
          );
        }
      case ErrorState:
        _dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          //show popup
          _showPopup(context, getMessage(), getStateRendererType(), retryFunc);
          return contentScreenWidget;
        } else //StateRendererType.fullScreenErrorState
        {
          return StateRenderer(
            type: getStateRendererType(),
            retryAction: retryFunc,
            message: getMessage(),
          );
        }
      case ContentState:
        // if theres is any dialog showing, dismiss it.
        _dismissDialog(context);
        return contentScreenWidget;
      case EmptyState:
        _dismissDialog(context);
        return StateRenderer(
          type: getStateRendererType(),
          retryAction: retryFunc,
          message: getMessage(),
        );
      case SuccessState:
        _dismissDialog(context);
        //show popup
        _showPopup(context, getMessage(), getStateRendererType(), retryFunc);
        return contentScreenWidget;
      default:
        return contentScreenWidget;
    }
  }

  void _dismissDialog(BuildContext context) {
    if (_isShowingDialog(context)) {
      //dismiss the showing dialog
      Navigator.of(context).pop(true);
    }
  }

  bool _isShowingDialog(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  _showPopup(BuildContext context, String message,
      StateRendererType stateRendererType, void Function() retryFunc) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) => StateRenderer(
                type: stateRendererType,
                retryAction: retryFunc,
                message: message,
              ));
    });
  }
}
