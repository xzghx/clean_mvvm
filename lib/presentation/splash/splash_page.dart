import 'dart:async';

import 'package:clean_mvvm_project/presentation/resources/color_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  _start() {
    _timer = Timer(const Duration(seconds: 1), _goMainPage);
  }

  void _goMainPage() {
    Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute);
  }

  @override
  void initState() {
    _start();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 20, spreadRadius: 1, color: ColorManager.grey1),
            ],
          ),
          child: const Image(
            image: AssetImage(ImageAssets.splashLogo),
          ),
        ),
      ),
    );
  }
}
