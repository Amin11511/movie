import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user_dm/user_model.dart';


class AuthService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://route-movie-apis.vercel.app/"),
  );

  Future<UserDm> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      "auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200 && response.statusCode! < 300) {
      final data = response.data;

      final token = data["data"];
      final message = data["message"];

      print("Login response: $data");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      // بنعمل UserDm من الـ token
      return UserDm.fromToken(
        token,
        email: email,
      );
    } else {
      throw Exception("Login failed");
    }
  }

  Future<UserDm> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    try {
      final response = await _dio.post(
        "auth/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "phone": phone,
          "avaterId": avaterId,
        },
      );

      print("Register response data: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UserDm.fromJson(response.data['data']);
      } else {
        throw Exception("Register failed with status ${response.statusCode}: ${response.data}");
      }
    } on DioException catch (e) {
      print("DioException response data: ${e.response?.data}");
      throw Exception("Register failed: ${e.response?.data}");
    }
  }

  Future<String> resetPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.patch(
        "auth/reset-password",
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      print("Reset Password response: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data["message"] ?? "Password updated successfully";
      } else {
        throw Exception(
          "Reset Password failed with status ${response.statusCode}: ${response.data}",
        );
      }
    } on DioException catch (e) {
      print("DioException response data: ${e.response?.data}");
      throw Exception("Reset Password failed: ${e.response?.data}");
    }
  }
}

