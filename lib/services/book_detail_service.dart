// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class BookDetailService {
  final ApiClient _apiClient = ApiClient();

  /// get book details
  Future<Map<String, dynamic>?> getBookDetails(int userId, [int? bookId]) async {
    debugPrint(
        "Sending request to get book details for userId: $userId, bookId: ${bookId ?? '123'}");

    try {
      final response = await _apiClient.get(
        'getBooks.php',
        queryParams: {
          "user_id": userId,
          if (bookId != null) "book_id": bookId,
        },
      );

      debugPrint("Response received from getBooks.php: $response");
      return response;
    } catch (e) {
      debugPrint("Error while fetching book details: $e");
      return null;
    }
  }
}