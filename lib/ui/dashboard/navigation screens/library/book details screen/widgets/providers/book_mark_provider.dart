import 'package:flutter/foundation.dart';

class BookmarkProvider with ChangeNotifier {
  bool _isBookmarked = false;

  bool get isBookmarked => _isBookmarked;

  void toggleBookmark() {
    _isBookmarked = !_isBookmarked;
    notifyListeners();
  }
}
