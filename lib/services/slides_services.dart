// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class SlidesServices {
  final ApiClient _apiClient = ApiClient();

  /// get slider images
  Future<Map<String, dynamic>?> getSlides() async {
    try {
      return await _apiClient.get('get_slides.php');
    } catch (e) {
      debugPrint("Error while fetching slides: $e");
      return null;
    }
  }
}
