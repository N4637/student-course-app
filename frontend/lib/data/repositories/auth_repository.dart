import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../dataProvider/auth_provider.dart';

class AuthRepository {
    final AuthProvider authProvider;
    final FlutterSecureStorage _storage = FlutterSecureStorage();
    
    AuthRepository(this.authProvider);

    Future<void> createToken(String token) async {
      await _storage.write(key:'token', value:token);
    }

    Future<void> deleteToken() async {
      await _storage.delete(key:'token');
    }

    Future<bool> hasToken() async {
        final token = await _storage.read(key: 'token');
        if(token!=null && token.isNotEmpty){return true;}
        else{return false;}
    }

    Future<bool> login(String id , String password) async {
      final token = await authProvider.login(id,password);
      if(token!=null && token.isNotEmpty){
        await createToken(token);
        return true;
      }
      else{return false;}
    }

    Future<bool> signUp(String name, String id, String password) async {
      final token = await authProvider.signUp(name,id,password);
      if(token!=null && token.isNotEmpty){
        await createToken(token);
        return true;
      }
      else{return false;}
    }
}