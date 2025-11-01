import 'package:dio/dio.dart';

import '../model/user_model.dart';

class ApiProvider {
  final String baseUrl = 'https://hurried-fleta-prismatically.ngrok-free.dev/api';
  final Dio _dio = Dio();

  // Register Method
  Future<Response?> register({required String phoneNumber,required String password,required String name}) async {
    try {
      final response = await _dio.post(
        '$baseUrl/register/',
        data: {"name":name,
          "mobile": phoneNumber,
          "password": password,
        },
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('❌ Server error: ${e.response?.data}');
        return e.response;
      } else {
        print('⚠️ Network error: ${e.message}');
        return null;
      }
    } catch (e) {
      print('⚠️ Unexpected error: $e');
      return null;
    }
  }

  // Login Method → returns token if success
  Future<UserModel?> login(String phoneNumber, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login/',
        data: {
          "mobile": phoneNumber,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // assuming server returns token like {"token": "xyz..."}
        final userModel = UserModel.fromJson(response.data);
        print('✅ Login successful! Token: ${userModel.token}');
        return userModel;
      } else {
        print('⚠️ Login failed: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('❌ Server error: ${e.response?.data}');
        return null;
      } else {
        print('⚠️ Network error: ${e.message}');
        return null;
      }
    } catch (e) {
      print('⚠️ Unexpected error: $e');
      return null;
    }
  }
}
