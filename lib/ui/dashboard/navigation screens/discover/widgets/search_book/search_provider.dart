// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:laylah_app/services/search_book_service.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/search_book/search_model.dart';

class SearchBarProvider with ChangeNotifier {
  SearchBookService _searchBarServices = SearchBookService();

  SearchModel? _searchModel;
  SearchModel? get searchModel => _searchModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> searchQuery(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _searchBarServices.searchQuery(query);
      if (response != null && response.data != null) {
        _searchModel = response;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
