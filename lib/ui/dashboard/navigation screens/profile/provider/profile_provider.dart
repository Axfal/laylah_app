// ignore_for_file: avoid_print, empty_catches

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/model/get_user_data_model.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/model/update_profile_data.model.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class ProfileProvider with ChangeNotifier {
  final _profileService = ProfileServices();

  GetUserData? _getUserData;
  GetUserData? get getUserData => _getUserData;

  Future<void> fetchUserData(context) async {
    _loading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      print("User ID: $userId");
      try {
        final response = await _profileService.getUserData(userId);
        if (response != null && response["success"] != null) {
          _getUserData = GetUserData.fromJson(response);
        }
      } catch (e) {
        print("the error while fetching the data: $e");
      } finally {
        _loading = false;
        notifyListeners();
      }
    } else {
      print("User ID not found");
    }
  }

  UpdateUserData? _updateUserData;
  UpdateUserData? get updateUserData => _updateUserData;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> updateProfile(
    BuildContext context,
    String userName,
    String email,
    String phone,
    String address,
    File image,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      print("User ID: $userId");

      FormData formData = FormData.fromMap({
        "user_id": userId,
        "userName": userName,
        "email": email,
        "phone": phone,
        "address": address,
        "image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      _loading = true;
      notifyListeners();

      try {
        final response = await _profileService.postUserData(formData);

        if (response != null && response["success"] != null) {
          _updateUserData = UpdateUserData.fromJson(response);
          print("Profile updated successfully.");
        } else {
          print("Failed to update profile. Response: $response");
        }
      } catch (e) {
        print("Error during profile update: $e");
        rethrow;
      } finally {
        _loading = false;
        notifyListeners();
      }
    } else {
      print("User ID not found in SharedPreferences.");
    }
  }
}
