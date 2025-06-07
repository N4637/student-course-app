import 'dart:convert';
import 'package:http/http.dart' as http;
import '../repositories/auth_repository.dart';
import './auth_provider.dart';
import '../models/course.dart';

class CourseProvider {
  static const String _baseUrl = 'http://10.0.2.2:8080/api';
  final http.Client client;
  late final AuthRepository _authRepository;

  CourseProvider({required this.client}) {
    _authRepository = AuthRepository(AuthProvider(client: client));
  }

  Future<List<Course>> getEnrolledCourses() async {
    String? token = await _authRepository.getToken();

    if (token == null) {
      throw Exception('No token found, please login.');
    }

    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/enrolledCourses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final courses = jsonList.map((json) => Course.fromJson(json)).toList();
        return courses;
      } else {
        throw Exception('Failed to fetch courses');
      }
    } catch (error) {
      throw Exception('Error fetching courses: $error');
    }
  }

  Future<bool> addCourses(List<Course> courses) async {
    String? token = await _authRepository.getToken();

    if (token == null) {
      throw Exception('No token found, please login.');
    }

    try {
      
      final coursesJson = courses.map((course) => course.toJson()).toList();
      print("Sending this JSON to backend: $coursesJson");
      final response = await client.post(
        Uri.parse('$_baseUrl/enrolledCourses/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(coursesJson),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Error adding courses: $error');
    }
  }

  Future<bool> dropCourse(List<Course> course) async {
    String? token = await _authRepository.getToken();

    if (token == null) {
      throw Exception('No token found, please login.');
    }

    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/enrolledCourses/drop'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(course.map((c) => c.toJson()).toList()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Error dropping course: $error');
    }
  }

  Future<List<Course>> getAvailableCourses() async {
    String? token = await _authRepository.getToken();

    if (token == null) {
      throw Exception('No token found, please login.');
    }

    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/availableCourses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final courses = jsonList.map((json) => Course.fromJson(json)).toList();
        return courses;
      } else {
        throw Exception('Failed to fetch available courses');
      }
    } catch (error) {
      throw Exception('Error fetching available courses: $error');
    }
  }
}
