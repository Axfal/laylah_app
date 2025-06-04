// ignore_for_file: prefer_final_fields, avoid_print

import 'package:laylah_app/services/book_detail_service.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/model/book_detail_model.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class BookDetailProvider with ChangeNotifier {
  BookDetailService _bookDetailService = BookDetailService();

  BookDetailModel? _bookDetailModel;
  BookDetailModel? get bookDetail => _bookDetailModel;

  void disposeData() {
    _bookDetailModel = null;
  }

  Future<void> getBookDetails(BuildContext context, [int? bookId]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId == null) {
      print(
          "User ID not found in SharedPreferences. User might not be logged in.");
      return;
    }

    print("Fetching book details for bookId: $bookId and userId: $userId");

    try {
      final response = bookId == null
          ? await _bookDetailService.getBookDetails(userId)
          : await _bookDetailService.getBookDetails(userId, bookId);

      print("API response received: $response");

      if (response != null && response["status"] == "success") {
        _bookDetailModel = BookDetailModel.fromJson(response);
        print("Book details parsed successfully.");
        notifyListeners();
      } else {
        print("No data found for the user with ID $userId.");
      }
    } catch (e) {
      print("Error occurred while fetching book details: $e");
    }
  }
}
