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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    context.read<AuthBloc>().add(
      LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }

  void _goToSignUp() => context.read<AuthBloc>().add(ShowSignPage());

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
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoggedIn) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Failed")),
              );
            }
          },
          builder: (context, state) {
            if (state is EntryLoad) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: login,
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: _goToSignUp,
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
