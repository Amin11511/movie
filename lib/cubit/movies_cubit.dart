import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movies_dm/movi_model.dart';
import 'package:movie/services/movies_service.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}
class MoviesLoading extends MoviesState {}
class MoviesLoaded extends MoviesState {
  final List<MovieModel> movies;
  MoviesLoaded(this.movies);
}
class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
}

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesService service;

  MoviesCubit(this.service) : super(MoviesInitial());

  void loadMovies() async {
    emit(MoviesLoading());
    try {
      final movies = await service.fetchMovies();
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
