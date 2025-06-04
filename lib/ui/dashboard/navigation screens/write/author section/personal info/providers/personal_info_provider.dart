import 'package:flutter/cupertino.dart';

class PersonalInfoProvider with ChangeNotifier {
  /// Age-related state management
  bool _isUnder18 = true;

  /// For the "Select Country" field (Country Name)
  String? selectedCountryName;

  /// For phone number (Country Code)
  String? selectedCountryCode = 'US';
  String? phoneNumber;


  /// Getter and setter for the selected country name (for "Select Country" field)
  String? get getSelectedCountryName => selectedCountryName;

  void setSelectedCountryName(String countryName, String countryCode) {
    selectedCountryName = countryName;
    /// Update country code as well
    selectedCountryCode = countryCode;
    notifyListeners();
  }

  /// Getter and setter for the selected country code (for Phone Number field)
  String? get getSelectedCountryCode => selectedCountryCode;

  void setSelectedCountryCode(String countryCode) {
    selectedCountryCode = countryCode;
    notifyListeners();
  }

  /// Getter and setter for phone number
  String? get getPhoneNumber => phoneNumber;

  void setPhoneNumber(String number) {
    phoneNumber = number;
    notifyListeners();
  }

  /// Age-related state management
  bool get isUnder18 => _isUnder18;

  void setAgeStatus(bool isUnder18) {
    _isUnder18 = isUnder18;
    notifyListeners();
  }
}
