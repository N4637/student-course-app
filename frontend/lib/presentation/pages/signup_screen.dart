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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  final TextEditingController _confController = TextEditingController();

  void _onCreate(BuildContext context) {
    if (_pswdController.text != _confController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    context.read<AuthBloc>().add(
      SignUpReq(
        name: _nameController.text,
        email: _emailController.text,
        password: _pswdController.text,
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

            Future.delayed(Duration(seconds: 1), () {
              context.read<AuthBloc>().add(ShowLoginPage());
            });
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
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Enter Your Name"),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Enter Your Email"),
                  ),
                  TextFormField(
                    controller: _pswdController,
                    decoration: InputDecoration(labelText: "Enter Password"),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _confController,
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
