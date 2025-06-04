// ignore_for_file: prefer_final_fields, avoid_print, empty_catches

import 'package:laylah_app/services/library_services.dart';
import 'package:laylah_app/utils/constants/exports.dart';

import '../model/get_library_books_model.dart';

class LibraryBooksProvider with ChangeNotifier {
  final _libraryServices = LibraryServices();

  bool _loading = false;
  bool get loading => _loading;

  GetLibraryBookModel? _getLibraryBookModel;
  GetLibraryBookModel? get getLibraryModel => _getLibraryBookModel;

  final Set<int> _loadingBooks = {};
  bool isBookLoading(int bookId) => _loadingBooks.contains(bookId);

  bool inLibrary(int bookId) {
    return _getLibraryBookModel?.books?.any((book) => book.bookId == bookId) ??
        false;
  }

  /// get library books
  Future<void> getLibraryBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      print("User ID: $userId");
      try {
        _loading = true;
        notifyListeners();
        final response = await _libraryServices.getLibraryBooks(userId);
        if (response != null && response["status"] == "success") {
          _getLibraryBookModel = GetLibraryBookModel.fromJson(response);
        } else {
          print("error in response data type");
        }
      } catch (e) {
        debugPrint("error while fetching the data : $e");
      } finally {
        _loading = false;
        notifyListeners();
      }
    } else {
      print("user id is null anfal dear");
    }
  }

  Future<void> addBookToLibrary(context, int bookId) async {
    _loadingBooks.add(bookId);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      try {
        Map<String, dynamic> data = {"user_id": userId, "book_id": bookId};
        print("book id: $bookId and user id: $userId");
        final response = await _libraryServices.addLibraryBook(data);
        if (response != null && response["status"] == "success") {
          ToastHelper.showSuccess("${response["message"]}");
          await getLibraryBooks();
        } else {
          ToastHelper.showError("${response?['message']}");
        }
      } catch (e) {
        print("error while adding book : $e");
      } finally {
        _loadingBooks.remove(bookId); // <-- Stop loading
        notifyListeners();
      }
    }
  }

  /// remove book from library
  Future<bool> removeLibraryBook(context, int bookId) async {
    _loadingBooks.add(bookId);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      try {
        Map<String, dynamic> data = {"user_id": userId, "book_id": bookId};
        final response = await _libraryServices.removeLibraryBook(data);
        if (response != null && response["status"] == "success") {
          await getLibraryBooks();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${response["message"] ?? "Book removed"}"),
              backgroundColor: Colors.green));
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${response?["message"] ?? "Failed to remove"}"),
              backgroundColor: Colors.red));
          return false;
        }
      } catch (e) {
        print("error while removing book : $e");
        return false;
      } finally {
        _loadingBooks.remove(bookId); // <-- Stop loading
        notifyListeners();
      }
    } else {
      return false;
    }
  }

  // /// add book in library
  // Future<void> addBookToLibrary(context, int bookId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt('user_id');
  //
  //   if (userId != null) {
  //     print("User ID: $userId");
  //     try {
  //       Map<String, dynamic> data = {"user_id": userId, "book_id": bookId};
  //       final response = await _libraryServices.addLibraryBook(data);
  //       if (response != null && response["status"] == "success") {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content:
  //                 Text("${response["message"] ?? "Book added to library"}"),
  //             backgroundColor: Colors.green));
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content: Text(
  //                 "${response!["message"] ?? "Book not found in library or already removed."}"),
  //             backgroundColor: Colors.red));
  //       }
  //     } catch (e) {
  //       print("error while adding book : $e");
  //     } finally {
  //       _loading = false;
  //       notifyListeners();
  //     }
  //   } else {
  //     print("user id is null");
  //   }
  // }
  //
  // /// remove book from library
  // Future<bool> removeLibraryBook(context, int bookId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt('user_id');
  //
  //   if (userId != null) {
  //     try {
  //       _loading = true;
  //       notifyListeners();
  //       Map<String, dynamic> data = {"user_id": userId, "book_id": bookId};
  //       final response = await _libraryServices.removeLibraryBook(data);
  //       if (response != null && response["status"] == "success") {
  //         await getLibraryBooks();
  //         Navigator.of(context).pop();
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content: Text("${response["message"] ?? "Book removed"}"),
  //             backgroundColor: Colors.green));
  //         return true;
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content: Text("${response?["message"] ?? "Failed to remove"}"),
  //             backgroundColor: Colors.red));
  //         return false;
  //       }
  //     } catch (e) {
  //       print("error while removing book : $e");
  //       return false;
  //     } finally {
  //       _loading = false;
  //       notifyListeners();
  //     }
  //   } else {
  //     print("user id is null");
  //     return false;
  //   }
  // }
}
