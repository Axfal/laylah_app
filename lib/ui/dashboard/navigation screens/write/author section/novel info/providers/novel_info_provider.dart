// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laylah_app/services/add_book_services.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/model/add_book_model.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class NovelInfoProvider extends ChangeNotifier {
  final _addBookServices = AddBookServices();

  AddBookModel? _addBookModel;
  AddBookModel? get addBookModel => _addBookModel;

  /// Book cover image list and limits
  final List<String> _bookCovers = [];
  final int _maxCovers = 1;

  ///word count
  int _wordCount = 0;

  /// Dropdown options
  late String _selectedNovelType = 'Original';
  late String _selectedGenre = 'Fantasy';
  final List<String> _selectedTags = [];

  /// Form fields
  String _bookTitle = '';
  String _targetAudience = '';
  String _contentRating = '';
  String _selectedLanguage = 'English';
  String _bookDescription = '';

  /// State management
  bool _isNextEnabled = false;
  bool _isLoading = false;

  /// Getters for state variables
  String get bookTitle => _bookTitle;
  String get targetAudience => _targetAudience;
  String get contentRating => _contentRating;
  String get selectedLanguage => _selectedLanguage;
  List<String> get bookCovers => _bookCovers;
  bool get canAddMoreCovers => _bookCovers.length < _maxCovers;
  bool get isNextEnabled => _isNextEnabled;
  bool get isLoading => _isLoading;
  String get bookDescription => _bookDescription;
  int get wordCount => _wordCount;
  String get selectedNovelType => _selectedNovelType;
  String get selectedGenre => _selectedGenre;
  List<String> get selectedTags => _selectedTags;

  /// Available options
  final List<String> novelTypes = ['Original', 'Nonfiction'];
  final List<String> genres = ['Fantasy', 'Romance', 'Thriller', 'Sci-Fi'];
  final List<String> tags = ['Adventure', 'Mystery', 'Drama', 'Comedy'];

  Future<void> addBook(
      String bookTitle,
      String language,
      String targetAudience,
      String contentRating,
      String novelType,
      String genre,
      String description,
      bool ongoing,
      String authorName,
      String words,
      String views,
      String likes,
      String numOfChapter,
      File image,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      print("User ID: $userId");

      FormData formData = FormData.fromMap({
        "tag_id[]": 5,
        "book_title": bookTitle,
        "language": language,
        "target_audience": targetAudience,
        "content_rating": contentRating,
        "novel_type": novelType,
        "genre": genre,
        "description": description,
        "ongoing": ongoing,
        "user_id": userId,
        "author_name": authorName,
        "words": words,
        "views": views,
        "likes": likes,
        "number_of_chapters": numOfChapter,
        "book_cover_image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      try {
        _isLoading = true;
        notifyListeners();

        final response = await _addBookServices.addBook(userId, formData);

        if (response != null && response["status"] == "success") {
          _addBookModel = AddBookModel.fromJson(response);
          notifyListeners();
        }
      } catch (e) {
        print("Error adding book: $e");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      print("User ID not found in SharedPreferences.");
    }
  }


  /// Update Book Description
  void updateBookDescription(String description) {
    if (_bookDescription != description) {
      _bookDescription = description.trim();
      notifyListeners();
    }
  }

  /// Available languages
  final List<String> languages = ['English', 'Urdu', 'Hindi'];

  /// Update Selected Language
  void updateSelectedLanguage(String newLanguage) {
    if (_selectedLanguage != newLanguage) {
      _selectedLanguage = newLanguage;
      _checkNextButton();
      notifyListeners();
    }
  }

  /// Update Target Audience
  void updateTargetAudience(String audience) {
    if (_targetAudience != audience) {
      _targetAudience = audience;
      _checkNextButton();
      notifyListeners();
    }
  }

  /// Update Content Rating
  void updateContentRating(String rating) {
    if (_contentRating != rating) {
      _contentRating = rating;
      _checkNextButton();
      notifyListeners();
    }
  }

  /// Add Book Cover from Gallery
  Future<void> addImageFromGallery() async {
    if (!canAddMoreCovers) return;

    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _bookCovers.add(pickedFile.path);
        _checkNextButton();
        notifyListeners();
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  /// Remove Book Cover
  void removeImage(int index) {
    if (index >= 0 && index < _bookCovers.length) {
      if (kDebugMode) {
        print("Removing image at index: $index");
      }
      _bookCovers.removeAt(index);
      _checkNextButton();
      notifyListeners();
    } else {
      debugPrint("Invalid index for removing image.");
    }
  }

  /// Update Book Title
  void restrictBookTitle(String title) {
    final trimmedTitle = title.trim();
    if (_bookTitle != trimmedTitle) {
      _bookTitle = trimmedTitle;
      _checkNextButton();
      notifyListeners();
    }
  }

  /// Set Loading State
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Check if the "Next" button should be enabled
  void _checkNextButton() {
    _isNextEnabled = _bookTitle.isNotEmpty &&
        _targetAudience.isNotEmpty &&
        _contentRating.isNotEmpty;
  }

  /// Set a default book cover if no image is selected.
  void setBookCoverToDefaultImage() {
    // Update this to use a String path for assets.
    _bookCovers.add('assets/logo/default_book_cover.png');
    notifyListeners();
  }

  ///word count
  void updateWordCount(String text) {
    _wordCount =
        text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
    notifyListeners();
  }

  /// Update Novel Type
  void updateNovelType(String novelType) {
    if (_selectedNovelType != novelType) {
      _selectedNovelType = novelType;
      _checkNextButton();
      notifyListeners();
    }
  }

  /// Update Genre
  void updateGenre(String genre) {
    if (_selectedGenre != genre) {
      _selectedGenre = genre;
      _checkNextButton();
      notifyListeners();
    }
  }

  /// Update Tags (Multiple Selection)
  void toggleTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notifyListeners();
  }
}
