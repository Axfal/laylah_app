// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import '../../../utils/constants/exports.dart';

class AuthProvider with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Login
  Future<Map<String, dynamic>> login(
    context, {
    required String email,
    required String password,
  }) async {
    if (_isLoading) {
      return {
        "success": false,
        "message": "Please wait, already logging in...",
      };
    }

    setLoading(true);
    try {
      final response = await _apiClient.post('Sign-In.php', {
        'email': email,
        'password': password,
      });

      if (response == null) {
        return {
          "success": false,
          "message": "Something went wrong. Please try again later.",
        };
      }

      if (response.containsKey('error') && response['error'] != null) {
        return {
          "success": false,
          "message": response['error'] ?? 'An unknown error occurred',
        };
      }

      if (response.containsKey("success") == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt(
            'user_id', int.parse(response['user_id'].toString()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      }

      return {
        "success": true,
        "message": "Login successful",
        "data": response,
      };
    } catch (e) {
      return {
        "success": false,
        "message": "Login failed: ${e.toString()}",
      };
    } finally {
      setLoading(false);
    }
  }

  /// Signup
  Future<Map<String, dynamic>?> signupUser({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String imagePath,
  }) async {
    setLoading(true);
    try {
      FormData formData = FormData.fromMap({
        "user_name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "password": password,
        "image": await MultipartFile.fromFile(
          imagePath,
          filename: "profile.jpg",
        ),
      });

      final response = await _apiClient.post('Signup.php', formData);
      return response;
    } catch (e) {
      return {
        "success": false,
        "message": "Signup failed: ${e.toString()}",
      };
    } finally {
      setLoading(false);
    }
  }
}
