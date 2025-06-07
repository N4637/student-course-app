import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/course/course_bloc.dart';
import '../bloc/course/course_events.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 16,
              ),
              tileColor: const Color.fromARGB(255, 153, 172, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'View Your Courses',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(
                Icons.menu_book_sharp,
                color: Colors.deepPurple,
                size: 50,
              ),
              onTap: () {
                context.read<CourseBloc>().add(GetEnrolledCourses());
                Navigator.pushNamed(context, '/enrolledCourses');
              },
            ),
            const SizedBox(height: 80),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 16,
              ),
              tileColor: const Color.fromARGB(255, 153, 172, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Enroll in Course',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.add, color: Colors.green, size: 50),
              onTap: () {
                context.read<CourseBloc>().add(GetAvailableCourses());
                Navigator.pushNamed(context, '/availableCourses');
              },
            ),
            const SizedBox(height: 80),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 16,
              ),
              tileColor: const Color.fromARGB(255, 153, 172, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Drop a Course',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.remove, color: Colors.red, size: 50),
              onTap: () {
                context.read<CourseBloc>().add(LoadDropPageCourses());
                Navigator.pushNamed(context, '/dropCourse');
              },
            ),
            const SizedBox(height: 80),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 16,
              ),
              tileColor: const Color.fromARGB(255, 153, 172, 208),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.logout, color: Colors.grey, size: 50),
              onTap: () {
                authBloc.add(LogoutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
