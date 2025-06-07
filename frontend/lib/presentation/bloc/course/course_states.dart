import '../../../data/models/course.dart';

abstract class CourseState {}

class LoadingState extends CourseState {}

class HomeState extends CourseState {}

class EnrolledPageState extends CourseState {
  final List<Course> enrolledCourses;
  EnrolledPageState(this.enrolledCourses);
}

class EnrollSuccess extends CourseState {}

class EnrollError extends CourseState {
  final String message;
  EnrollError(this.message);
}

class AvailablePageState extends CourseState {
  final List<Course> availableCourses;
  AvailablePageState(this.availableCourses);
}

class AvailSuccess extends CourseState {}

class AvailError extends CourseState {
  final String message;
  AvailError(this.message);
}

class DropPageState extends CourseState {
  final List<Course> enrolledCourses;
  DropPageState(this.enrolledCourses);
}

class DropSuccess extends CourseState {}

class DropError extends CourseState {
  final String message;
  DropError(this.message);
}
