// ignore_for_file: unused_field, prefer_final_fields, avoid_print

import 'package:laylah_app/services/writing_services.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/add_chapter/model/get_chapter_model.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class AuthorCenterProvider with ChangeNotifier {
  final _writingService = WritingServices();

  Map<int, GetChaptersModel> _draftChapter = {}; // bookId + book chapters
  Map<int, GetChaptersModel> get draftChapter => _draftChapter;

  Map<int, GetChaptersModel> _publishedChapter = {};
  Map<int, GetChaptersModel> get publishedChapter => _publishedChapter;

  Map<int, GetChaptersModel> _trashChapter = {};
  Map<int, GetChaptersModel> get trashChapter => _trashChapter;

  Map<int, bool> _isChapterPublished = {}; //chapterId + published or not
  Map<int, bool> get isChapterPublished => _isChapterPublished;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void clearChaptersForBook() {
    _draftChapter.clear();
    _publishedChapter.clear();
    notifyListeners();
  }

  /// get chapters
  Future<void> getChapters(int bookId, String? status, bool? trash) async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {
        "book_id": bookId,
        "status": status,
        "trash": trash
      };
      final response = await _writingService.getChapters(data);
      if (response != null && response["status"] == "success") {
        final parsedChapters = GetChaptersModel.fromJson(response);
        if (status == "draft" && trash == false) {
          _draftChapter[bookId] = parsedChapters;
        } else if (status == "published" && trash == false) {
          _publishedChapter[bookId] = parsedChapters;
        } else if (status == "draft" && trash == true) {
          _trashChapter[bookId] = parsedChapters;
        }
      } else {
        print("success = false");
      }
    } catch (e) {
      print("error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// add chapter
  Future<void> addChapters(context, int bookId, String chapterTitle,
      String chapterDescription, String status) async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      print('User ID: $userId');
      try {
        Map<String, dynamic> data = {
          "user_id": userId,
          "book_id": bookId,
          "chapter_title": chapterTitle,
          "chapter_content": chapterDescription,
          "status": status
        };
        final response = await _writingService.addChapters(data);
        if (response != null && response["status"] == "success") {
          ToastHelper.showSuccess('${response["message"] ?? ""}');
        } else {
          ToastHelper.showError(
              "${response!["message"] ?? "Chapter not added"}");
        }
      } catch (e) {
        print("error: $e");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      print('No user ID found.');
    }
  }

  /// trash draft chapter
  Future<void> trashDraftChapter(context, int chapterId) async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {"chapter_id": chapterId};
      final response = await _writingService.trashChapters(data);
      if (response != null && response["status"] == "success") {
        ToastHelper.showSuccess('${response["message"] ?? ""}');
      } else {
        ToastHelper.showError(
            "${response!["message"] ?? "Chapter delete failed"}");
      }
    } catch (e) {
      print("error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// delete trash chapter
  Future<void> deleteTrashChapter(context, int chapterId) async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {"chapter_id": chapterId};
      final response = await _writingService.deleteChapters(data);
      if (response != null && response["status"] == "success") {
        ToastHelper.showSuccess('${response["message"] ?? ""}');
      } else {
        ToastHelper.showError(
            "${response!["message"] ?? "Chapter delete failed"}");
      }
    } catch (e) {
      print("error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// restore chapter
  Future<void> restoreChapter(int chapterId) async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {"chapter_id": chapterId};
      final response = await _writingService.restoreTrashedChapters(data);
      if (response != null && response["status"] == "success") {
        ToastHelper.showSuccess('${response["message"] ?? ""}');
      } else {
        ToastHelper.showError(
            "${response!["message"] ?? "Chapter restored failed"}");
      }
    } catch (e) {
      print("error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// update Chapter
  Future<void> updateChapter(int chapterId, String chapterTitle,
      String chapterContent, String status) async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {
        "chapter_id": chapterId,
        "chapter_title": chapterTitle,
        "chapter_content": chapterContent,
        "status": status
      };
      final response = await _writingService.updateChapters(data);
      if (response != null && response["status"] == "success") {
        ToastHelper.showSuccess('${response["message"] ?? ""}');
      } else {
        ToastHelper.showError(
            "${response!["message"] ?? "Chapter restored failed"}");
      }
    } catch (e) {
      print("error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
