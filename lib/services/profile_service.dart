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

  Future<String> updateProfile({
    required String token,
    String? name,
    String? phone,
    int? avaterId,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name; // إرسال الـ name حتى لو فاضي
      if (phone != null) data['phone'] = phone; // إرسال الـ phone حتى لو فاضي
      if (avaterId != null) data['avaterId'] = avaterId;
      // أسماء بديلة لو الـ backend بيستخدمها
      if (name != null) data['username'] = name;
      if (phone != null) data['phoneNumber'] = phone;

      print("Sending data to updateProfile: $data"); // للتصحيح

      final response = await _dio.patch(
        "profile",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      print("Update Profile response: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data["message"] ?? "Profile updated successfully";
      } else {
        throw Exception(
          "Update Profile failed with status ${response.statusCode}: ${response.data}",
        );
      }
    } on DioException catch (e) {
      print("DioException response data: ${e.response?.data}");
      throw Exception("Update Profile failed: ${e.response?.data}");
    }
  }

  Future<String> deleteAccount(String token) async {
    try {
      final response = await _dio.delete(
        "profile",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      print("Delete Account response: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data["message"] ?? "Account deleted successfully";
      } else {
        throw Exception(
          "Delete Account failed with status ${response.statusCode}: ${response.data}",
        );
      }
    } on DioException catch (e) {
      print("DioException response data: ${e.response?.data}");
      throw Exception("Delete Account failed: ${e.response?.data}");
    }
  }
}
