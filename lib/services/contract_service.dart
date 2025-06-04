// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class ContractService {
  final ApiClient _apiClient = ApiClient();

  /// sign contract for book
  Future<Map<String, dynamic>?> contractService(dynamic data) async {
    try {
      return await _apiClient.post('add_contracts.php', data);
    } catch (e) {
      debugPrint("Error while applying for contract: $e");
      return null;
    }
  }

  /// check contract for book
  Future<Map<String, dynamic>?> checkContractService(dynamic data) async {
    try {
      return await _apiClient.post('check_user_contract.php', data);
    } catch (e) {
      debugPrint("Error while checking the contract for book of the user: $e");
      return null;
    }
  }
}
