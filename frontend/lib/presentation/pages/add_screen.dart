import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/course.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/course/course_states.dart';
import '../bloc/course/course_events.dart';

class EnrollCourseScreen extends StatelessWidget {
  const EnrollCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Courses'),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AvailablePageState) {
            final List<Course> courses = state.availableCourses;
            if (courses.isEmpty) {
              return const Center(child: Text('No available Courses at the moment'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                List<Course> inList = [course];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Text(course.course_name),
                    title: Text("Credits:${course.credits}"),
                    subtitle: Text('Code: ${course.course_code}'),
                     trailing: IconButton(onPressed: (){
                      context.read<CourseBloc>().add(AddCourses(courses: inList));
                     }, 
                     icon: Icon(Icons.add, color: Colors.green),),
                  ),
                );
              },
            );
          } else if (state is AvailError) {
            return Center(child: Text('Error: ${state.message}'));
          } 
          return const SizedBox(width: 16,);
        },
      ),
    );
  }
}
