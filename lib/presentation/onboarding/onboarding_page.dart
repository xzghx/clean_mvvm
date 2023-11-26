import 'package:clean_mvvm_project/presentation/resources/assets_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/color_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/strings_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/durations.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late final List<OnBoardingObject> _slider = _getSlider();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<OnBoardingObject> _getSlider() {
    return [
      OnBoardingObject(AppStrings.onBoardingTitle1,
          AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingImage1),
      OnBoardingObject(AppStrings.onBoardingTitle2,
          AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingImage2),
      OnBoardingObject(AppStrings.onBoardingTitle3,
          AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingImage3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          itemCount: _slider.length,
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return OnBoardingView(
              onBoarding: _slider[index],
            );
          }),
      bottomSheet: SizedBox(
        height: 100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.skip,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            _getBottom(),
          ],
        ),
      ),
    );
  }

  Widget _getBottom() {
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
                _pageController.animateToPage(_getPrevPage(),
                    duration: const Duration(milliseconds: Durations.d300),
                    curve: Curves.easeInCirc);
              },
            ),
          ),
          // Circles
          Row(
            children: [
              for (int i = 0; i < _slider.length; i++)
                i == _currentIndex
                    ? const Icon(Icons.circle)
                    : const Icon(Icons.circle_outlined)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s1_5),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _pageController.animateToPage(_getNextPage(),
                    duration: const Duration(milliseconds: Durations.d300),
                    curve: Curves.easeInCirc);
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getPrevPage() {
    int prev = _currentIndex - 1;
    if (prev == -1) {
      prev = _slider.length - 1;
    }
    return prev;
  }

  int _getNextPage() {
    int next = _currentIndex + 1;
    if (next == _slider.length) {
      next = 0;
    }
    return next;
  }
}

class OnBoardingView extends StatelessWidget {
  final OnBoardingObject onBoarding;

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

class OnBoardingObject {
  final String title;

  final String subTitle;

  final String image;

  OnBoardingObject(this.title, this.subTitle, this.image);
}
