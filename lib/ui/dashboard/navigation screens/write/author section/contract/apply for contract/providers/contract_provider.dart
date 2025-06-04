// ignore_for_file: avoid_print, prefer_final_fields, prefer_const_constructors

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import 'package:path/path.dart';

class ContractProvider with ChangeNotifier {
  final contractService = ContractService();

  // Loading state
  bool _loading = false;
  bool get loading => _loading;

  // Track selected indexes and values for each contract option group
  final List<int> _selectedIndexes = [0, 0, 0, 0, 0];
  final List<String> _selectedValues = [
    'Alpha Contract', // contract type
    'Exclusive', //preferred binding
    'Yes', // completed offline
    'Yes', // available online
    'Yeah' // have payoneer account
  ];

  // Track text field values for form validation
  String _bookTitle = '';
  String _contractType = '';
  String _preferredBinding = '';
  String _numberOfWords = '';
  String _payoneerAccount = '';
  int _selectedYear = 0;
  bool _isNextEnabled = false;
  final bool _isLoading = false;

  // Getters
  List<int> get selectedIndexes => _selectedIndexes;
  List<String> get selectedValues => _selectedValues;
  int get selectedYear => _selectedYear;
  String get bookTitle => _bookTitle;
  String get contractType => _contractType;
  String get preferredBinding => _preferredBinding;
  String get numberOfWords => _numberOfWords;
  String get payoneerAccount => _payoneerAccount;
  bool get isNextEnabled => _isNextEnabled;
  bool get isLoading => _isLoading;

  // Update selected contract option
  void selectContractOption(
      int contractIndex, int optionIndex, String optionValue) {
    if (_selectedIndexes[contractIndex] != optionIndex) {
      _selectedIndexes[contractIndex] = optionIndex;
      _selectedValues[contractIndex] = optionValue;
      notifyListeners();
    }
  }

  // Get selected string value for a group
  String selectedButtonValue(int index) {
    if (index >= 0 && index < _selectedValues.length) {
      return _selectedValues[index];
    }
    return '';
  }

  // Methods to update number of years
  void selectTwoYears() => _updateSelectedYear(2);
  void selectThreeYears() => _updateSelectedYear(3);
  void selectFourYears() => _updateSelectedYear(4);
  void selectFiveYears() => _updateSelectedYear(5);

  void _updateSelectedYear(int year) {
    if (_selectedYear != year) {
      _selectedYear = year;
      // _validateForm();
      notifyListeners();
    }
  }

  // Update form field values
  void setBookTitle(String title) {
    _bookTitle = title;
    _validateForm();
    notifyListeners();
  }

  void setContractType(String type) {
    _contractType = type;
    notifyListeners();
  }

  void setPreferredBinding(String binding) {
    _preferredBinding = binding;
    _validateForm();
    notifyListeners();
  }

  void setNumberOfWords(String words) {
    _numberOfWords = words;
    _validateForm();
    notifyListeners();
  }

  void _validateForm() {
    _isNextEnabled = _bookTitle.isNotEmpty &&
        _preferredBinding.isNotEmpty &&
        _numberOfWords.isNotEmpty &&
        _selectedYear > 0;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _contractExist = false;
  bool get contractExist => _contractExist;

  Future<void> signContract(
    context,
    String bookId,
    String bookTitle,
    String contractType,
    String bindingType,
    String durationYear,
    String expectedWords,
    String avgWordsPerChapter,
    String completedOffline,
    String availableOnline, {
    String? onlineLink,
    String? fullName,
    String? penName,
    String? email,
    String? platformLink,
    String? country,
    String? state,
    String? city,
    String? address,
    String? zipCode,
    String? above18,
    String? phoneNumber,
    File? idFront,
    File? idBack,
    File? passport,
    File? drivingLicense,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userIdInt = prefs.getInt('user_id');
      if (userIdInt == null) return;
      String userId = userIdInt.toString();

      final formMap = <String, dynamic>{
        "user_id": userId,
        "book_id": bookId,
        "book_title": bookTitle,
        "contract_type": _selectedValues[0],
        "binding_type": _selectedValues[1],
        "duration_years": durationYear,
        "expected_words": expectedWords,
        "avg_words_per_chapter": avgWordsPerChapter,
        "completed_offline": completedOffline,
        "available_online": availableOnline,
        "online_link": onlineLink ?? '',
        "full_name": fullName ?? '',
        "pen_name": penName ?? '',
        "email": email ?? '',
        "platform_link": platformLink ?? '',
        "country": country ?? '',
        "state": state ?? '',
        "city": city ?? '',
        "address": address ?? '',
        "zip_code": zipCode ?? '',
        "is_above_18": above18 ?? '',
        "phone_number": phoneNumber ?? '',
      };

      if (idFront != null) {
        formMap["id_card_front"] = await MultipartFile.fromFile(
          idFront.path,
          filename: "id_card_front.jpg",
        );
      }
      if (idBack != null) {
        formMap["id_card_back"] = await MultipartFile.fromFile(
          idBack.path,
          filename: "id_card_back.jpg",
        );
      }
      if (passport != null) {
        formMap["passport"] = await MultipartFile.fromFile(
          passport.path,
          filename: "passport.jpg",
        );
      }
      if (drivingLicense != null) {
        formMap["driving_license"] = await MultipartFile.fromFile(
          drivingLicense.path,
          filename: "driving_license.jpg",
        );
      }

      final formData = FormData.fromMap(formMap);

      final response = await contractService.contractService(formData);

      if (response != null && response['status'] == 'success') {
        ToastHelper.showSuccess(response['message']);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
        if (!_contractExist) {
          await checkUserContract();
        }
      } else {
        ToastHelper.showError(response?['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// check contract of user
  Future<void> checkUserContract() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');

      if (userId == null) return;

      Map<String, dynamic> data = {"user_id": userId};
      final response = await contractService.checkContractService(data);

      if (response != null && response['status'] == 'success') {
        _contractExist = response['exists'];
      } else {
        _contractExist = false;
      }
    } catch (e) {
      ToastHelper.showError("$e");
    } finally {
      notifyListeners();
    }
  }
}
