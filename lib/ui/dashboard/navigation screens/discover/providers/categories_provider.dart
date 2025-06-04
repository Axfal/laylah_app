// ignore_for_file: prefer_final_fields, avoid_print

import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/model/discover_model.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class CategoriesProvider extends ChangeNotifier {
  DiscoverService _discoverService = DiscoverService();
  DiscoverModel? _discoverModel;
  DiscoverModel? get discoverModel => _discoverModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }


  Future<void> getCategoryBooks() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      print('Fetching category books...');
      final response = await _discoverService.getCategories();

      if (response != null && response["data"] != null) {
        print('Data fetched successfully: ${response.toString()}');
        _discoverModel = DiscoverModel.fromJson(response);
        print('DiscoverModel: $_discoverModel');
      } else {
        _errorMessage = 'Failed to fetch data.';
        print('Failed to fetch data: ${response?.toString()}');
      }
    } catch (e) {
      _errorMessage = 'Error while fetching data: $e';
      print('Error while fetching data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
