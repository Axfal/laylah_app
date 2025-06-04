import '../ui/dashboard/navigation screens/discover/widgets/search_book/search_model.dart';
import 'base_services/network_services.dart';

class SearchBookService {
  final ApiClient _apiClient = ApiClient();

  SearchModel? _searchModel;
  SearchModel? get searchModel => _searchModel;

  /// Searching books
  Future<SearchModel?> searchQuery(String query) async {
    try {
      final response = await _apiClient.get(
        'search_api.php',
        queryParams: {"book_title": query},
      );

      if (response != null && response["status"] == "success") {
        _searchModel = SearchModel.fromJson(response);
        return _searchModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error fetching search results: $e");
    }
  }
}
