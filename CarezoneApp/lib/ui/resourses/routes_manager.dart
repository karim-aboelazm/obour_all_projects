import 'package:flutter/material.dart';
import '../auth/authscreen.dart';
import '../main/main._view.dart';
import '../onboarding/onboarding.dart';
import '../splash/splash_view.dart';
import '../start/get_start.dart';
import 'Strings_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String getstarted = '/getstarted';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
  static const String advicescreen = '/advicescreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: ((_) => const SplashScreen()));
      case Routes.onBoarding:
        return MaterialPageRoute(builder: ((_) => const OnBoardingView()));
      case Routes.mainRoute:
        return MaterialPageRoute(builder: ((_) => const Mainpage()));
      case Routes.getstarted:
        return MaterialPageRoute(builder: ((_) => const GetStart()));
      case Routes.login:
        return MaterialPageRoute(builder: ((_) => const Authscreen()));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
