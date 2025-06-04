// ignore_for_file: unused_field, prefer_final_fields

import 'package:laylah_app/utils/constants/exports.dart';

class WritingServices {
  final ApiClient _apiClient = ApiClient();

  /// get chapters
  Future<Map<String, dynamic>?> getChapters(dynamic data) async {
    try {
      return await _apiClient.get('get_chapters.php', queryParams: data);
    } catch (e) {
      debugPrint("Error while fetching chapter: $e");
      return null;
    }
  }

  /// add chapters
  Future<Map<String, dynamic>?> addChapters(dynamic data) async {
    try {
      return await _apiClient.post('add_chapter.php', data);
    } catch (e) {
      debugPrint("Error while adding chapter: $e");
      return null;
    }
  }

  /// trash chapters
  Future<Map<String, dynamic>?> trashChapters(dynamic data) async {
    try {
      return await _apiClient.delete('trash-chapter.php', data: data);
    } catch (e) {
      debugPrint("Error while trash chapter: $e");
      return null;
    }
  }

  /// delete chapters
  Future<Map<String, dynamic>?> deleteChapters(dynamic data) async {
    try {
      return await _apiClient.delete('delete_chapter.php', data: data);
    } catch (e) {
      debugPrint("Error while deleting chapter: $e");
      return null;
    }
  }

  /// restore trashed chapters
  Future<Map<String, dynamic>?> restoreTrashedChapters(dynamic data) async {
    try {
      return await _apiClient.put('restore-chapter.php', data);
    } catch (e) {
      debugPrint("Error while restoring trashed chapter: $e");
      return null;
    }
  }

  /// update chapters
  Future<Map<String, dynamic>?> updateChapters(dynamic data) async {
    try {
      return await _apiClient.put('update_chapter.php', data);
    } catch (e) {
      debugPrint("Error while updating chapter: $e");
      return null;
    }
  }
}
