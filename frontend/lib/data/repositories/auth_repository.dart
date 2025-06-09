import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../dataProvider/auth_provider.dart';

class AuthRepository {
  final AuthProvider authProvider;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthRepository(this.authProvider);

  Future<void> createToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<bool> hasToken() async {
    return authProvider.validate();
  }

  Future<bool> login(String email, String password) async {
    try {
      final token = await authProvider.login(email, password);
      if (token != null && token.isNotEmpty) {
        await createToken(token);
        return true;
      }
    } catch (e) {return false;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final token = await authProvider.register(name, email, password);
      if (token != null && token.isNotEmpty) {
        await createToken(token);
        return true;
      }
    } catch (e) {return false;
    }
    return false;
  }
}
