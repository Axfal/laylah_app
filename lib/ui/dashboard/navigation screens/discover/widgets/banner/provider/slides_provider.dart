// ignore_for_file: avoid_print

import 'package:laylah_app/utils/constants/exports.dart';

class SlidesProvider with ChangeNotifier {
  final SlidesServices _slidesServices = SlidesServices();

  SlidesModel? _slidesModel;
  SlidesModel? get slidesModel => _slidesModel;

  Future<void> getSlides() async {
    try {
      final response = await _slidesServices.getSlides();
      if (response != null && response["status"] == "success") {
        _slidesModel = SlidesModel.fromJson({
          "status": response["status"] ?? "unknown",
          "data": response["data"] ?? [],
        });
        notifyListeners();
      } else {
        print("API Response error: ${response?["message"]}");
      }
    } catch (e) {
      debugPrint("Error in SlidesProvider: $e");
      rethrow;
    }
  }
}
