abstract class AuthEvents {}

class ShowSignPage extends AuthEvents {}
class ShowLoginPage extends AuthEvents {}
class ShowHomePage extends AuthEvents {}
class AppStarted extends AuthEvents {}

class LoginRequest extends AuthEvents {
  final id;
  final password;

  LoginRequest({
    required this.id,
    required this.password,
  });
}

class SignUpReq extends AuthEvents {
  final name;
  final id;
  final email;
  final password;
  SignUpReq({
    required this.name,
    required this.id,
    required this.email,
    required this.password,
  });
}