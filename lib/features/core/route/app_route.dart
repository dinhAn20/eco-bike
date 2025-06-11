import 'package:eco_bike/features/app/home/pages/home.dart';
import 'package:eco_bike/features/app/home/pages/splash.dart';
import 'package:eco_bike/features/auth/presentation/pages/signin.dart';
import 'package:eco_bike/features/auth/presentation/pages/signup.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String initialRoute = SplashPage.routeName;
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashPage.routeName: (context) => const SplashPage(),
    HomePage.routeName: (context) => const HomePage(),
    SigninPage.routeName: (context) => SigninPage(),
    SignupPage.routeName: (context) => SignupPage(),
  };
}
