abstract class AuthEvents {}

class ShowSignPage extends AuthEvents {}

class ShowLoginPage extends AuthEvents {}

class ShowHomePage extends AuthEvents {}

class AppStarted extends AuthEvents {}

class LogoutEvent extends AuthEvents {}

class LoginRequest extends AuthEvents {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}

class SignUpReq extends AuthEvents {
  final String name;
  final String email;
  final String password;

  SignUpReq({
    required this.name,
    required this.email,
    required this.password,
  });
}
