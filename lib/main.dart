import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/cubit/movies_cubit.dart';
import 'package:movie/screens/home_screen/home.dart';
import 'package:movie/screens/splash/splash.dart';
import 'package:movie/services/movies_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesService service = MoviesService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => MoviesCubit(service)..loadMovies(),
        child:const  Home(),
      ),
    );
  }
}
