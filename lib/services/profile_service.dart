import 'package:dio/dio.dart';
import '../user_dm/user_model.dart';

class ProfileService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://route-movie-apis.vercel.app/"),
  );

  Future<UserDm> getProfile(String token) async {
    try {
      final response = await _dio.get(
        "profile",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      print("Get Profile response: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data["data"];
        return UserDm.fromJson(data);
      } else {
        throw Exception(
          "Get Profile failed with status ${response.statusCode}: ${response.data}",
        );
      }
    } on DioException catch (e) {
      print("DioException response data: ${e.response?.data}");
      throw Exception("Get Profile failed: ${e.response?.data}");
    }
  }
}
