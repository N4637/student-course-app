import '../../../data/models/course.dart';
abstract class CourseEvents {}

class GetEnrolledCourses extends CourseEvents{}

class GetAvailableCourses extends CourseEvents{}

class DropCourse extends CourseEvents{
  final List<Course> course;
  DropCourse({
    required this.course,
  });
}

class LoadDropPageCourses extends CourseEvents {}

class AddCourses extends CourseEvents{
  final List<Course> courses;
  AddCourses({
    required this.courses,
  });
}

class BackToHome extends CourseEvents {}