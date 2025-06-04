// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class ProfileServices {
  final ApiClient _apiClient = ApiClient();

  /// get user data
  Future<Map<String, dynamic>?> getUserData(int userId) async {
    debugPrint("Sending request to get user data for userId: $userId");

    try {
      final response = await _apiClient.get(
        '/get_user_data.php',
        queryParams: {"user_id": userId},
      );

      debugPrint("Response received from get user data.php: $response");
      return response;
    } catch (e) {
      debugPrint("Error while fetching user details: $e");
      return null;
    }
  }

  /// post user data
  Future<Map<String, dynamic>?> postUserData(dynamic data) async {
    debugPrint("Sending request to post user data");

    try {
      final response = await _apiClient.post("/update_profile.php", data);

      debugPrint("Response received from update user data.php: $response");
      return response;
    } catch (e) {
      debugPrint("Error while updating user details: $e");
      return null;
    }
  }
}
