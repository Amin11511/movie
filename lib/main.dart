import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/cubit/movies_cubit.dart';
import 'package:movie/screens/home_screen/home.dart';
import 'package:movie/screens/splash/splash.dart';
import 'package:movie/services/movies_service.dart';
import 'package:movie/utilities/app_colors.dart';

void main() {
  final MoviesService service = MoviesService();
  runApp(MyApp(service: service));
}

class MyApp extends StatelessWidget {
  final MoviesService service;
  const MyApp({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoviesCubit(service)..loadMovies(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColor.black),
        home: const Splash(),
      ),
    );
  }
}

