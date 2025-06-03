class AuthProvider {
  
  Future<String?> login(String id, String password) async {
    await Future.delayed(Duration(seconds: 1));

    if (id == 'hello' && password == 'hello123') {
      return 'mock_jwt_token';
    } else {
      return null;
    }
  }

  Future<String?> signUp(String name, String id, String password) async {
    await Future.delayed(Duration(seconds: 1));

    if (name.isNotEmpty && id.isNotEmpty && password.length >= 6) {
      return 'mock_jwt_token_after_signup';
    } else {
      return null;
    }
  }
}
