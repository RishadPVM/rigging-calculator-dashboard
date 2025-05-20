import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor
  factory ApiService() => _instance;

  // Private constructor
  ApiService._internal();

  // Headers for API requests
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // GET request
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {..._defaultHeaders, ...?headers},
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<dynamic> post(String url, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {..._defaultHeaders, ...?headers},
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<dynamic> putFormData(
  String url, {
  Map<String, String>? fields,
  Map<String, File>? files,
  Map<String, String>? headers,
}) async {
  try {
    final uri = Uri.parse(url);
    final request = http.MultipartRequest('PUT', uri);

    // Add headers
    request.headers.addAll({
      ..._defaultHeaders,
      if (headers != null) ...headers,
    });

    // Add fields
    if (fields != null) {
      request.fields.addAll(fields);
    }

    // Add files
    if (files != null) {
      for (final entry in files.entries) {
        final file = await http.MultipartFile.fromPath(entry.key, entry.value.path);
        request.files.add(file);
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _handleResponse(response);
  } catch (e) {
    throw _handleError(e);
  }
}

Future<dynamic> postFormData(
  String url, {
  Map<String, String>? fields,
  Map<String, File>? files,
  Map<String, String>? headers,
}) async {
  try {
    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);

    // Add headers
    request.headers.addAll({
      ..._defaultHeaders,
      if (headers != null) ...headers,
    });

    // Add fields
    if (fields != null) {
      request.fields.addAll(fields);
    }

    // Add files
    if (files != null) {
      for (final entry in files.entries) {
        final file = await http.MultipartFile.fromPath(entry.key, entry.value.path);
        request.files.add(file);
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _handleResponse(response);
  } catch (e) {
    throw _handleError(e);
  }
}


  // PUT request
  Future<dynamic> put(String url, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {..._defaultHeaders, ...?headers},
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {..._defaultHeaders, ...?headers},
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Handle API response
  dynamic _handleResponse(http.Response response) {
  final statusCode = response.statusCode;
  final responseBody = json.decode(response.body);

  if (statusCode >= 200 && statusCode < 300) {
    return responseBody;
  } else {
    throw Exception(responseBody['error'] ?? responseBody['message'] ?? 'Unknown error');
  }
}


  // Handle errors
  Exception _handleError(dynamic error) {
    if (error is http.ClientException) {
      return Exception('Network error: Please check your internet connection');
    }
    return Exception('Unexpected error: $error');
  }
}
