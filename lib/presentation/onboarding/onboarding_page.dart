import 'package:clean_mvvm_project/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:clean_mvvm_project/presentation/resources/color_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/strings_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/model/model.dart';
import '../resources/routes_manager.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start(); //fills slider list
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnBoardingViewObject>(
        stream: _viewModel.outputViewObject,
        builder: (context, snapshot) => _getContent(snapshot.data));
  }

  Widget _getBottom(OnBoardingViewObject onBoardingViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s1_5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                _viewModel.onPrev();
              },
            ),
          ),
          // Circles
          Row(
            children: [
              for (int i = 0; i < onBoardingViewObject.numOfSlides; i++)
                i == onBoardingViewObject.currentIndex
                    ? const Icon(Icons.circle)
                    : const Icon(Icons.circle_outlined)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s1_5),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _viewModel.onNext();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContent(OnBoardingViewObject? data) {
    return data == null
        ? const Center(
            child: Text('Empty'),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: AppSize.s0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorManager.white,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: PageView.builder(
                itemCount: data.numOfSlides,
                controller: _pageController,
                onPageChanged: (int index) {
                  _viewModel.onPageChanged(index);
                },
                itemBuilder: (context, index) {
                  return OnBoardingView(
                    onBoarding: data.onBoardingObject,
                  );
                }),
            bottomSheet: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.loginRoute);
                      },
                      child: Text(
                        AppStrings.skip,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  _getBottom(data),
                ],
              ),
            ),
          );
  }
}

class OnBoardingView extends StatelessWidget {
  final SliderObject onBoarding;

  const OnBoardingView({super.key, required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p12),
          child: Text(
            onBoarding.title,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p12),
          child: Text(
            onBoarding.subTitle,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        Image(image: AssetImage(onBoarding.image)),
      ],
    );
  }
}
