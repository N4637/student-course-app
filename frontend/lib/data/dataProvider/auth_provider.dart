import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/auth';
  final http.Client client;

  AuthProvider({required this.client});

  Future<String?> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<String?> register(String name, String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  String? _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return body['token'];
    } else {
      throw Exception(body['message'] ?? 'Request failed');
    }
  }
}