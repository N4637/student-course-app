import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './data/dataProvider/auth_provider.dart';
import './data/dataProvider/course_provider.dart';
import './data/repositories/auth_repository.dart';
import './data/repositories/course_repository.dart';
import './presentation/pages/signup_screen.dart';
import './presentation/pages/login_screen.dart';
import './presentation/pages/home_screen.dart';
import './presentation/pages/enrolled_screen.dart';
import './presentation/pages/drop_screen.dart';
import './presentation/bloc/auth/auth_bloc.dart';
import './presentation/bloc/auth/auth_events.dart';
import './presentation/bloc/auth/auth_states.dart';
import './presentation/bloc/course/course_bloc.dart'; 
import './presentation/pages/add_screen.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final courseProvider = CourseProvider(client: http.Client());
  final authProvider = AuthProvider(client: http.Client());
  late final authRepository = AuthRepository(authProvider);
  late final courseRepository = CourseRepository(courseProvider);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final bloc = AuthBloc(authRepository);
            bloc.add(AppStarted());
            return bloc;
          },
        ),
        BlocProvider<CourseBloc>(
          create: (context) => CourseBloc(courseRepository), 
        ),
      ],
      child: MaterialApp(
        title: 'Student Enroll App',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const HomeScreen(),
          '/enrolledCourses': (context) => const EnrolledCoursesScreen(),
          '/availableCourses': (context) => const EnrollCourseScreen(),
           '/dropCourse': (context) => const DropCourseScreen(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is EntryLoad) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is LoggedIn) {
              return const HomeScreen();
            } else if (state is SignUpState) {
              return const SignUpScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
