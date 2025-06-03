import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  AuthBloc(): super(EntryLoad()) {

    on<AppStarted>((event,emit) async {
      emit(EntryLoad());
      final token = await _storage.read(key: 'token');

      if(token!=null && token.isNotEmpty){
        emit(LoggedIn());
      }
      else{
        emit(LoginState());
      }
    });
    
    on<ShowLoginPage>((event, emit) {
      emit(LoginState());
    });

    on<ShowSignPage>((event, emit){
      emit(SignUpState());
    });

    on<ShowHomePage>((event, emit){
      emit(LoggedIn());
    });

    on<LoginRequest>((event, emit) async{
      emit(EntryLoad());

      await Future.delayed(Duration(seconds: 2));

      if(event.id=="hello" && event.password=="hello123"){
        await _storage.write(key: 'token', value: 'mock_jwt_token');
        emit(LoginSuccess());
      }
      else{
        emit(LoginError("Invalid Credentials"));
      }
    });

    on<SignUpReq>((event, emit)async {
      emit(EntryLoad());

      await Future.delayed(Duration(seconds: 2));

       if (event.id.isNotEmpty &&
          event.email.contains('@') &&
          event.password.length >= 6){
    
          await _storage.write(key: 'token', value: 'mock_jwt_token_after_signup');
          emit(SignUpSuccess());
      } 
      else {
        emit(SignUpError());
      }
    });

  }
}
