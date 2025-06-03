abstract class AuthState {}

class EntryLoad extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

class SignUpSuccess extends AuthState {}

class SignUpError extends AuthState {}

class LoggedIn extends AuthState {}  

class LoginState extends AuthState {}  

class SignUpState extends AuthState {}  

class LogoutState extends AuthState {}  
