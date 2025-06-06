import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_events.dart';
import '../bloc/auth/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _psswdController = TextEditingController();

  void _onLogPress() => context.read<AuthBloc>().add(
    LoginRequest(email: _mailController.text, password: _psswdController.text),
  );

  void _onSignPress() => context.read<AuthBloc>().add(ShowSignPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is LoggedIn) {
            await Future.delayed(Duration(milliseconds: 100));
            if (mounted) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          }

          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Log In Failed"),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is EntryLoad) {
            return Center(
              child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _mailController,
                          decoration: InputDecoration(
                            labelText: 'Enter Your Email',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _psswdController,
                          decoration: InputDecoration(
                            labelText: 'Enter Password',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _onLogPress,
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    ElevatedButton(
                      onPressed: _onSignPress,
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
