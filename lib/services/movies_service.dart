import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/movies_dm/movi_model.dart';

class MoviesService {
  final String baseUrl = 'https://yts.mx/api/v2/list_movies.json';

  Future<List<MovieModel>> fetchMovies({String? genre}) async {
    try {
      final url = genre == null
          ? baseUrl
          : '$baseUrl?genre=$genre';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final moviesList = data['data']['movies'] as List<dynamic>;
        return moviesList.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }


  // Search by title
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await http.get(Uri.parse("$baseUrl?query_term=$query"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final moviesList = data['data']['movies'] as List?;
      if (moviesList == null) return [];
      return moviesList.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
