import 'package:flutter/material.dart';
import '../screens/home_screen/home.dart';
import '../screens/onboarding/onboarding.dart';
import '../screens/onboarding/onboarding1.dart';
import '../screens/onboarding/onboarding2.dart';
import '../screens/splash/splash.dart';

abstract final class AppRoutes{
  static Route get splash => MaterialPageRoute(builder: (_) => Splash());
  static Route get home => MaterialPageRoute(builder: (_) => Home());
  static Route get onboarding1 => MaterialPageRoute(builder: (_) => Onboarding1());
  static Route get onboarding2 => MaterialPageRoute(builder: (_) => Onboarding2());
  static Route get onboarding => MaterialPageRoute(builder: (_) => OnBoarding());
}