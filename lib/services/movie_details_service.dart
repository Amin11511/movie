import 'package:dio/dio.dart';
import '../movie_details_dm/movie_details_dm.dart';

class MovieDetailsService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://yts.mx/api/v2/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  /// Get movie details by [movieId]
  Future<MovieDetailsDm> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        "movie_details.json",
        queryParameters: {"movie_id": movieId},
      );

      if (response.statusCode == 200 && response.data != null) {
        return MovieDetailsDm.fromJson(response.data);
      } else {
        throw Exception("Failed to load movie details");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<List<dynamic>> getMovieSuggestions(int movieId) async {
    final String url = "https://yts.mx/api/v2/movie_suggestions.json";

    try {
      final response = await _dio.get(url, queryParameters: {
        "movie_id": movieId,
      });

      if (response.statusCode == 200) {
        final data = response.data;

        if (data["status"] == "ok" && data["data"] != null) {
          return data["data"]["movies"] ?? [];
        } else {
          return [];
        }
      } else {
        throw Exception("Failed to load suggestions: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching suggestions: $e");
    }
  }
}

