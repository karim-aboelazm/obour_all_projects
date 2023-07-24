import 'package:flutter/material.dart';
import '../resourses/Color_manager.dart';
import '../resourses/Strings_manager.dart';
import '../resourses/assets_manager.dart';
import '../resourses/routes_manager.dart';
import '../resourses/styles_manager.dart';
import '../resourses/values_manager.dart';

class GetStart extends StatefulWidget {
  const GetStart({super.key});
  @override
  State<StatefulWidget> createState() {
    return GetStartState();
  }
}

class GetStartState extends State<GetStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Image(
                  image: const AssetImage(ImageAssets.splashLogo),
                  color: ColorManager.darkGrey,
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.carezone,
                  style:
                      getBoldStyle(color: ColorManager.darkGrey, fontSize: 30),
                ),
              ]),
              Column(children: [
                Text(
                  'Let’s get started!',
                  style: getBoldStyle(color: ColorManager.grey, fontSize: 22),
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Text(
                  'Login to enjoy the features we’ve provided, and stay healthy!',
                  textAlign: TextAlign.center,
                  style:
                      getRegularStyle(color: ColorManager.grey1, fontSize: 17),
                ),
              ]),
              field('Log In', ColorManager.splash, ColorManager.white)
            ],
          ),
        ),
      ),
    );
  }

  TextFormField field(String x, Color y, Color z) {
    return TextFormField(
      onTap: () => Navigator.pushReplacementNamed(context, Routes.login),
      readOnly: true,
      decoration: InputDecoration(
        labelText: x,
        labelStyle: getRegularStyle(
          color: z,
          fontSize: AppSize.s20,
        ),
        filled: true,
        fillColor: y,
      ),
    );
  }
}
