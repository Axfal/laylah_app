// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class LibraryServices {
  final ApiClient _apiClient = ApiClient();

  /// get library books
  Future<Map<String, dynamic>?> getLibraryBooks(int userId) async {
    debugPrint(
        "Sending request to get library book details for userId: $userId");

    try {
      final response = await _apiClient.get(
        'get_library.php',
        queryParams: {"user_id": userId},
      );

      debugPrint("Response received from getLibraryBooks.php: $response");
      return response;
    } catch (e) {
      debugPrint("Error while fetching library book details: $e");
      return null;
    }
  }

  /// add book to library
  Future<Map<String, dynamic>?> addLibraryBook(dynamic data) async {
    debugPrint("Sending request to add book to library details");

    try {
      final response = await _apiClient.post("add_library.php", data);

      debugPrint("Response received from add_library.php: $response");
      return response;
    } catch (e) {
      debugPrint("Error while adding book to library: $e");
      return null;
    }
  }

  /// remove book from library
  Future<Map<String, dynamic>?> removeLibraryBook(dynamic data) async {
    debugPrint("Sending request to remove book from library ");

    try {
      final response =
          await _apiClient.post("remove_book_from_library.php", data);

      debugPrint(
          "Response received from remove_book_from_library.php: $response");
      return response;
    } catch (e) {
      debugPrint("Error while removing book from library: $e");
      return null;
    }
  }

}
