// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import '../../../../../../../../models/chapter_model.dart';

class ChapterProvider extends ChangeNotifier {

  final List<Chapter> _chapters = [];

  List<Chapter> get chapters => _chapters;

  void addChapter() {
    _chapters.add(Chapter(title: '', content: ''));
    notifyListeners();
  }

  void removeChapter(int index) {
    if (index >= 0 && index < _chapters.length) {
      _chapters.removeAt(index);
      notifyListeners();
    }
  }

  void updateChapterTitle(int index, String title) {
    if (index >= 0 && index < _chapters.length) {
      _chapters[index].title = title;
      notifyListeners();
    }
  }

  void updateChapterContent(int index, String content) {
    if (index >= 0 && index < _chapters.length) {
      _chapters[index].content = content;
      notifyListeners();
    }
  }
}
