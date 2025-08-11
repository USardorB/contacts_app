import 'dart:convert';

import 'package:contacts_app/feature/home/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class NetworkService {
  Future<dynamic> get(String endPoint, {Map<String, String>? headers});
  Future<UserModel> post(String endPoint,
      {dynamic body, Map<String, String>? headers});
  Future<UserModel> put(String endPoint,
      {dynamic body, Map<String, String>? headers});
  Future<UserModel> delete(String endPoint, {Map<String, String>? headers});
}

class NetworkServiceImpl extends NetworkService {
  final String baseUrl;
  final http.Client client;

  NetworkServiceImpl({
    required this.baseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Sample profile images for demonstration
  static const List<String> profileImages = [
    "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww",
    'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
    'https://thumbs.dreamstime.com/b/portrait-handsome-smiling-young-man-folded-arms-smiling-joyful-cheerful-men-crossed-hands-isolated-studio-shot-172869765.jpg',
    'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGVyc29ufGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cGVyc29ufGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1463453091185-61582044d556?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cGVyc29ufGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cGVyc29ufGVufDB8fDB8fHww',
  ];

  // Sample call times for demonstration
  static const List<String> callTimes = [
    '2 minutes ago',
    '15 minutes ago',
    '20 minutes ago',
    '25 minutes ago',
    '30 minutes ago',
    '40 minutes ago',
    '45 minutes ago',
    '1 hour ago',
    '2 hours ago',
    '3 hours ago',
  ];

  @override
  Future<dynamic> get(String endPoint, {Map<String, String>? headers}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl$endPoint'),
        headers: headers ?? _defaultHeaders,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw NetworkException(
          'HTTP ${response.statusCode}: ${response.body}',
          response.statusCode,
        );
      }
    } on FormatException catch (e) {
      throw NetworkException('Invalid response format: $e');
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<UserModel> post(String endPoint,
      {dynamic body, Map<String, String>? headers}) {
    // TODO: Implement POST functionality
    throw UnimplementedError('POST method not implemented yet');
  }

  @override
  Future<UserModel> put(String endPoint,
      {dynamic body, Map<String, String>? headers}) {
    throw UnimplementedError('PUT method not implemented yet');
  }

  @override
  Future<UserModel> delete(String endPoint, {Map<String, String>? headers}) {
    throw UnimplementedError('DELETE method not implemented yet');
  }

  /// Get a profile image URL by index
  static String getProfileImage(int index) {
    return profileImages[index % profileImages.length];
  }

  /// Get a call time by index
  static String getCallTime(int index) {
    return callTimes[index % callTimes.length];
  }
}

/// Custom exception for network-related errors
class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'NetworkException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
