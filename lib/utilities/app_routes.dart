import 'package:flutter/material.dart';
import 'package:movie/screens/auth/forget_password/forget_password.dart';
import 'package:movie/screens/auth/register/register.dart';
import 'package:movie/screens/home_screen/movie_details_screen/movie_details.dart';
import '../screens/auth/login/login.dart';
import '../screens/home_screen/home.dart';
import '../screens/home_screen/update_profile/update_profile.dart';
import '../screens/onboarding/onboarding.dart';
import '../screens/onboarding/onboarding1.dart';
import '../screens/onboarding/onboarding2.dart';
import '../screens/splash/splash.dart';
import '../user_dm/user_model.dart';

abstract final class AppRoutes{
  static Route get splash => MaterialPageRoute(builder: (_) => Splash());
  static Route home(UserDm user) => MaterialPageRoute(builder: (_) => Home(user: user));
  static Route get onboarding1 => MaterialPageRoute(builder: (_) => Onboarding1());
  static Route get onboarding2 => MaterialPageRoute(builder: (_) => Onboarding2());
  static Route get onboarding => MaterialPageRoute(builder: (_) => OnBoarding());
  static Route get login => MaterialPageRoute(builder: (_) => Login());
  static Route get register => MaterialPageRoute(builder: (_) => Register());
  static Route get forgetPassword => MaterialPageRoute(builder: (_) => ForgetPassword());
  static Route updateProfile() => MaterialPageRoute(builder: (_) => const UpdateProfile());
  static Route movieDetails(int movieId) {return MaterialPageRoute(builder: (_) => MovieDetails(movieId: movieId),);}
}