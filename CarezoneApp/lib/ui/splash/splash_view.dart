import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resourses/Color_manager.dart';
import '../resourses/Strings_manager.dart';
import '../resourses/assets_manager.dart';
import '../resourses/constant_manager.dart';
import '../resourses/routes_manager.dart';
import '../resourses/styles_manager.dart';
import '../resourses/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstant.splashDelay), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.onBoarding);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.splash,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.splash,
              statusBarBrightness: Brightness.dark),
        ),
        backgroundColor: ColorManager.splash,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage(ImageAssets.splashLogo)),
              const SizedBox(
                height: AppSize.s20,
              ),
              Text(
                AppStrings.carezone,
                style: getBoldStyle(color: ColorManager.white, fontSize: 30),
              )
            ],
          ),
        ));
  }
}
