import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movies_dm/movi_model.dart';
import '../../services/movies_service.dart';

abstract class SearchState {}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<MovieModel> movies;
  SearchLoaded(this.movies);
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

class SearchCubit extends Cubit<SearchState> {
  final MoviesService service;
  SearchCubit(this.service) : super(SearchInitial());

  void searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final movies = await service.searchMovies(query);
      emit(SearchLoaded(movies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
