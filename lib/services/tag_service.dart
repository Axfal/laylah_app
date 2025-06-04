// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class TagService {
  final ApiClient _apiClient = ApiClient();

  /// get tags
  Future<Map<String, dynamic>?> getTags() async {
    try {
      return await _apiClient.get('get_tags.php');
    } catch (e) {
      debugPrint("Error while fetching tags: $e");
      return null;
    }
  }
}
