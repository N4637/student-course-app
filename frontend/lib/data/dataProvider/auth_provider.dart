import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/auth';
  final http.Client client;

  AuthProvider({required this.client});

  Future<String?> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return _handleResponse(response);
    } catch (error) {
      throw Exception('Login failed: ${error}');
    }
  }

  Future<bool> validate() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    if (token == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/validate'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

  Future<String?> register(String name, String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      return _handleResponse(response);
    } catch (error) {
      throw Exception('Registration failed: ${error}');
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
