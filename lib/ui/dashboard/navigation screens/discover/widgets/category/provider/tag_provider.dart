// ignore_for_file: prefer_final_fields

import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/category/model/tag_model.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class TagProvider with ChangeNotifier {
  TagService _tagService = TagService();

  TagsModel? _tagsModel;
  TagsModel? get tagModel => _tagsModel;

  List<String> _tags = [];
  List<String> get tags => _tags;

  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;

  Future<void> getTags() async {
    try {
      final response = await _tagService.getTags();

      if (response != null && response["status"] == "success") {
        _tagsModel = TagsModel.fromJson({"data": response["data"]});
        _tags = _tagsModel?.data?.map((tag) => tag.tagName ?? '').toList() ?? [];
      } else {
        _tagsModel = null;
        _tags = [];
      }

      notifyListeners();
    } catch (e) {
      print("Error in getTags: $e");
      rethrow;
    }
  }

  void toggleTagSelection(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notifyListeners();
  }

  void clearSelectedTags() {
    _selectedTags.clear();
    notifyListeners();
  }
}
