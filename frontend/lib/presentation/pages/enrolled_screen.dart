import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/course.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/course/course_states.dart';
import '../bloc/course/course_events.dart';

class EnrolledCoursesScreen extends StatelessWidget {
  const EnrolledCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9796F0), Color(0xFFFBC7D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Your Enrolled Courses'),
        ),
        body: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EnrolledPageState) {
              final List<Course> courses = state.enrolledCourses;
              if (courses.isEmpty) {
                return const Center(child: Text('No enrolled courses found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(course.course_name),
                      subtitle: Text('Code: ${course.course_code}'),
                      trailing: Text('${course.credits} credits'),
                    ),
                  );
                },
              );
            } else if (state is EnrollError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox(width: 16);
          },
        ),
      ),
    );
  }
}
