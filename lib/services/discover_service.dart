// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class DiscoverService {
  final ApiClient _apiClient = ApiClient();

  /// get books
  Future<Map<String, dynamic>?> getCategories() async {
    try {
      return await _apiClient.get('get_discover.php');
    } catch (e) {
      debugPrint("Error while fetching books: $e");
      return null;
    }
  }
}
