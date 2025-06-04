// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class AuthServices {
  final ApiClient _apiClient = ApiClient();

  /// Sign-In
  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    try {
      return await _apiClient.post('Sign-In.php', {
        "email": email,
        "password": password,
      });
    } catch (e) {
      debugPrint("AuthServices signIn error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> signUp(String userName, String email,
      String address, String phone, String password) async {
    try {
      return await _apiClient.post('Signup.php', {
        "email": email,
        "password": password,
      });
    } catch (e) {
      debugPrint("AuthServices signIn error: $e");
      return null;
    }
  }
}
