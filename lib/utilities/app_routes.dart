import 'package:flutter/material.dart';
import '../screens/home_screen/home.dart';
import '../screens/splash/splash.dart';

abstract final class AppRoutes{
  static Route get splash => MaterialPageRoute(builder: (_) => Splash());
  static Route get home => MaterialPageRoute(builder: (_) => Home());
}