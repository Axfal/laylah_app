import 'dart:io';
import 'package:flutter/material.dart';

class DocumentUploadProvider with ChangeNotifier {
  File? idFront, idBack, passport, license;
  bool agreeTerms = false;

  void setImage(String type, File file) {
    switch (type) {
      case 'idFront':
        idFront = file;
        break;
      case 'idBack':
        idBack = file;
        break;
      case 'passport':
        passport = file;
        break;
      case 'license':
        license = file;
        break;
    }
    notifyListeners();
  }

  void toggleAgreement() {
    agreeTerms = !agreeTerms;
    notifyListeners();
  }

  bool get canSubmit => agreeTerms && idFront != null && idBack != null;
}
