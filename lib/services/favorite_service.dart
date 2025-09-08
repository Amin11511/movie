import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../favorites_dm/favorites_movie_dm.dart';
import '../movie_details_dm/movie_details_dm.dart';


class FavoriteService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://route-movie-apis.vercel.app/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// هيلبر ميثود تجيب التوكين المخزن
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  /// إضافة فيلم للمفضلة
  Future<bool> addToFavorite(MovieDetailsData movie) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception("No token found");

      // اختيار أفضل صورة
      String imageUrl = movie.largeCoverImage.isNotEmpty
          ? movie.largeCoverImage
          : (movie.mediumCoverImage.isNotEmpty
          ? movie.mediumCoverImage
          : movie.smallCoverImage);

      if (imageUrl.isEmpty && movie.backgroundImage.isNotEmpty) {
        imageUrl = movie.backgroundImage;
      }

      if (imageUrl.isNotEmpty &&
          !RegExp(r'^https?://', caseSensitive: false).hasMatch(imageUrl)) {
        imageUrl = 'https://$imageUrl';
      }

      final body = {
        "movieId": movie.id.toString(),
        "name": movie.titleEnglish.isNotEmpty ? movie.titleEnglish : movie.title,
        "rating": movie.rating,
        "imageURL": imageUrl,
        "year": movie.year.toString(),
      };

      print("➡️ Sending body: $body");

      final response = await _dio.post(
        "favorites/add",
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("❌ Error addToFavorite: $e");
      return false;
    }
  }

  /// إزالة فيلم من المفضلة
  Future<bool> removeFromFavorite(String movieId) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception("يجب تسجيل الدخول أولاً");

      final response = await _dio.delete(
        "favorites/remove/$movieId",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("❌ Error removeFromFavorite: $e");
      return false;
    }
  }

  /// جلب قائمة المفضلة
  Future<List<FavoriteMovieDm>> getAllFavorites() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception("No token found");

      final response = await _dio.get(
        "favorites/all",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data["data"] as List<dynamic>;
        return data.map((json) => FavoriteMovieDm.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("❌ Error getFavorites: $e");
      return [];
    }
  }
}