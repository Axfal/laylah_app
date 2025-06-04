// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'dart:convert';

/// Centralized API Client
class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://laylahnovel.com/API/',
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("Request: ${options.method} ${options.uri}");
        print("Headers: ${options.headers}");
        print("Body: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("Response [${response.statusCode}]: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("Dio Error: ${e.message}");
        if (e.response != null) {
          print("Error Response: ${e.response?.data}");
          print("Status Code: ${e.response?.statusCode}");
        }
        return handler.next(e);
      },
    ));
  }

  Future<Map<String, dynamic>?> get(String path,
      {Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(path, queryParameters: queryParams);
      print("Response received: ${response.data}");
      return _processResponse(response);
    } catch (e) {
      print("GET request error: $e");
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>?> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: data is FormData
              ? {"Content-Type": "multipart/form-data"}
              : {"Content-Type": "application/json"},
        ),
      );
      return _processResponse(response);
    } catch (e) {
      print("POST error: $e");
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>?> put(
      String path, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.put(path, data: data);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>?> delete(String path,
      {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.delete(path, data: data);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>?> patch(
      String path, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.patch(path, data: data);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>?> uploadFile(String path, String filePath,
      {Map<String, dynamic>? data}) async {
    try {
      FormData formData = FormData.fromMap({
        ...?data,
        "file": await MultipartFile.fromFile(filePath),
      });

      Response response = await _dio.post(path, data: formData);
      return _processResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Map<String, dynamic>? _processResponse(Response response) {
    dynamic responseData = response.data;
    print("Response Data: $responseData");

    if (responseData is String) {
      try {
        responseData = jsonDecode(responseData);
        print("Decoded response: $responseData");
      } catch (e) {
        print("Error decoding response: $e");
        return {
          "success": false,
          "message": "Error decoding the response data"
        };
      }
    }

    switch (response.statusCode) {
      case 200:
        if (responseData is Map<String, dynamic>) {
          return responseData;
        }
        return {
          "success": false,
          "message":
              "Response is not a Map<String, dynamic>, actual type: ${responseData.runtimeType}"
        };

      case 400:
        return {
          "success": false,
          "message": "Bad request. Please check your input."
        };

      case 401:
        return {
          "success": false,
          "message": "Unauthorized. Please check your credentials."
        };

      case 404:
        return {
          "success": false,
          "message": "Resource not found. Please check the URL or endpoint."
        };

      case 500:
        return {
          "success": false,
          "message": "Server error. Please try again later."
        };

      default:
        return {
          "success": false,
          "message":
              "Unexpected error occurred. Status Code: ${response.statusCode}"
        };
    }
  }

  Map<String, dynamic> _handleListData(List<dynamic> data) {
    if (data.isEmpty) {
      return {"success": false, "message": "Data list is empty."};
    }

    /// for get book details api
    if (data[0] is Map<String, dynamic>) {
      List<Map<String, dynamic>> structuredData = [];
      for (var item in data) {
        if (item is Map<String, dynamic>) {
          structuredData.add(item);
        } else {
          print("Invalid item in data list: $item");
        }
      }
      return {"success": true, "data": structuredData};
    } else if (data[0] is String) {
      List<String> items = [];
      for (var item in data) {
        if (item is String) {
          items.add(item);
        }
      }
      return {"success": true, "items": items};
    } else {
      return {
        "success": false,
        "message": "Unknown list structure: ${data.runtimeType}"
      };
    }
  }

  Map<String, dynamic>? _handleError(dynamic error) {
    if (error is DioException) {
      // Improved error handling
      return {
        "success": false,
        "message": error.response?.data?["message"] ??
            error.message ??
            "Server error occurred",
        "statusCode": error.response?.statusCode ?? 500,
      };
    }

    return {"success": false, "message": "Unexpected error occurred"};
  }
}
