// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class AddBookServices {
  final ApiClient _apiClient = ApiClient();

  /// add book details
  Future<Map<String, dynamic>?> addBook(int userId, dynamic data) async {
    debugPrint(
        "Sending request to add book details for userId: $userId");

    try {
      final response = await _apiClient.post("addBook.php", data);

      debugPrint("Response received from addBooks.php: $response");
      return response;
    } catch (e) {
      debugPrint("Error while adding book details: $e");
      return null;
    }
  }
}