import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_events.dart';
import '../bloc/auth/auth_states.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();
  final TextEditingController confController = TextEditingController();

  void _onCreate(BuildContext context) {
    if (pswdController.text != confController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    context.read<AuthBloc>().add(
      SignUpReq(
        name: nameController.text,
        email: emailController.text,
        password: pswdController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up Page')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Account Created Successfully")),
            );
            context.read<AuthBloc>().add(ShowLoginPage());
          }

          if (state is SignUpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Could Not Create Account")),
            );
          }
        },
        builder: (context, state) {

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Enter Your Name"),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Enter Your Email"),
                  ),
                  TextFormField(
                    controller: pswdController,
                    decoration: InputDecoration(labelText: "Enter Password"),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: confController,
                    decoration: InputDecoration(labelText: "Confirm Password"),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Builder(
                    builder: (localContext) => ElevatedButton(
                    onPressed: () => _onCreate(localContext),
                    child: Text("Create Account"),
  ),
),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
