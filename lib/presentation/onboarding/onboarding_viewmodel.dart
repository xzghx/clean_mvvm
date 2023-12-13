import 'dart:async';

import 'package:clean_mvvm_project/domain/model/model.dart';
import 'package:clean_mvvm_project/presentation/base/base_view_model.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController<OnBoardingViewObject> _streamController =
      StreamController<OnBoardingViewObject>();

  late final List<SliderObject> _slider;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _slider = _getSlider();
    //send _slider to View
    _postDataToView();
  }

  @override
  void onNext() {
    int next = _currentIndex + 1;
    if (next == _slider.length) {
      next = 0;
    }
    _currentIndex = next;
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  void onPrev() {
    int prev = _currentIndex - 1;
    if (prev == -1) {
      prev = _slider.length - 1;
    }
    _currentIndex = prev;
    _postDataToView();
  }

  @override
  Sink get inputViewObject => _streamController.sink;

  @override
  Stream<OnBoardingViewObject> get outputViewObject =>
      _streamController.stream.map((OnBoardingViewObject o) => o);

//example
// @override
// Stream<bool> get outputViewObject =>
//     _streamController.stream.map((password) => validatePassword(password))  ;

//Private Functions

  List<SliderObject> _getSlider() {
    return [
      SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1,
          ImageAssets.onBoardingImage1),
      SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2,
          ImageAssets.onBoardingImage2),
      SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3,
          ImageAssets.onBoardingImage3),
    ];
  }

  void _postDataToView() {
    inputViewObject.add(OnBoardingViewObject(
        _currentIndex, _slider.length, _slider[_currentIndex]));
  }
}

abstract class OnBoardingViewModelInputs {
  void onNext();

  void onPrev();

  void onPageChanged(int index);

  Sink get inputViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<OnBoardingViewObject> get outputViewObject;
}

class OnBoardingViewObject {
  final int currentIndex;
  final int numOfSlides;
  final SliderObject onBoardingObject;

  OnBoardingViewObject(
      this.currentIndex, this.numOfSlides, this.onBoardingObject);
}
