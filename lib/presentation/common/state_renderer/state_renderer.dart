import 'package:clean_mvvm_project/data/mapper/mapper.dart';
import 'package:clean_mvvm_project/presentation/resources/assets_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/strings_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
//for  popups
  popupLoadingState,
  popupErrorState,
  //for full screen
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState, //has data
  emptyScreenState, //no data
  popupSuccessState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType type;
  final String? message;
  final String? title;
  final void Function() retryAction;

  const StateRenderer({
    super.key,
    required this.type,
    this.message = AppStrings.loading,
    required this.retryAction,
    this.title = EMPTY,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case StateRendererType.popupLoadingState:
        return _GetDialog(children: [_getImage(JsonAssets.loadingJson)]);
      case StateRendererType.popupErrorState:
        return _GetDialog(children: [
          _getImage(JsonAssets.errorJson),
          _getMessage(message!, context),
          _retryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _ColumnWidget(children: [
          _getImage(JsonAssets.loadingJson),
          _getMessage(message!, context)
        ]);
      case StateRendererType.fullScreenErrorState:
        return _ColumnWidget(children: [
          _getImage(JsonAssets.errorJson),
          _getMessage(message ?? '', context),
          _retryButton(AppStrings.retry, context)
        ]);
      case StateRendererType.contentScreenState:
        return const SizedBox();
      case StateRendererType.emptyScreenState:
        return _ColumnWidget(children: [
          _getImage(JsonAssets.emptyJson),
          _getMessage(message!, context)
        ]);
      case StateRendererType.popupSuccessState:
        return _GetDialog(children: [
          const Icon(Icons.done_outline, color: Colors.greenAccent),
          _getMessage(title!, context),
          _getMessage(message!, context),
          _retryButton(AppStrings.ok, context)
        ]);
    }
  }

  _getMessage(String message, BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  _getImage(String jsonImage) {
    return SizedBox(
      width: AppSize.s100,
      height: AppSize.s100,
      child: Lottie.asset(jsonImage),
    );
  }

  _retryButton(String retry, BuildContext context) {
    return SizedBox(
      width: AppSize.s180,
      child: ElevatedButton(
          onPressed: () {
            if (type == StateRendererType.fullScreenErrorState) {
              retryAction.call();
            } else {
              //close the dialog
              Navigator.of(context).pop();
            }
          },
          child: Text(retry)),
    );
  }
}

class _GetDialog extends StatelessWidget {
  final List<Widget> children;

  const _GetDialog({required this.children});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14),
            shape: BoxShape.rectangle),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class _ColumnWidget extends StatelessWidget {
  final List<Widget> children;

  const _ColumnWidget({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
