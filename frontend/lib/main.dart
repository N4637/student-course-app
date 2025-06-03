import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/pages/signup_screen.dart';
import 'presentation/pages/login_screen.dart';
import 'presentation/pages/home_screen.dart'; 
import './presentation/bloc/auth/auth_bloc.dart';
import './presentation/bloc/auth/auth_events.dart';
import './presentation/bloc/auth/auth_states.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authBloc = AuthBloc();
        authBloc.add(AppStarted());
        return authBloc;
      },
      
      child: MaterialApp(
        title: 'Student Enroll App',
        home: BlocBuilder<AuthBloc,AuthState>(
          builder: (context, state){
            if(state is EntryLoad){
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            else if (state is LoggedIn|| state is LoginSuccess){
              return HomeScreen();
            }
            else if(state is SignUpState){
              return SignUpScreen();
            }
            else{
              return LoginScreen();
            }
          }),
      ),
    );
  }
}
