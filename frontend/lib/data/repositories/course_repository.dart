import '../dataProvider/course_provider.dart';
import '../models/course.dart';

class CourseRepository {
  final CourseProvider courseProvider;
  CourseRepository(this.courseProvider);

  Future<List<Course>> getEnrolledCourses() async {
    return await courseProvider.getEnrolledCourses();
  }

  Future<List<Course>> getAvailableCourses() async {
    return await courseProvider.getAvailableCourses();
  }

  Future<bool> addCourses(List<Course> courses) async {
    return await courseProvider.addCourses(courses);
  }

  Future<bool> dropCourse(List<Course> course) async {
    return await courseProvider.dropCourse(course);
  }
}