import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_events.dart';
import 'auth_states.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final AuthRepository authRepository;
  final _storage = FlutterSecureStorage();

  AuthBloc(this.authRepository): super(EntryLoad()) {

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

      final succ = await authRepository.login(event.id,event.password);
      if(succ){emit(LoggedIn());}
      else{
        emit(LoginError("Invalid Credentials"));
      }

    });

    on<SignUpReq>((event, emit)async {
      emit(EntryLoad());

      final succ = await authRepository.signUp(event.name, event.id, event.password);

      if(succ){
        emit(LoginState());
      }
      else{
        emit(SignUpError());
      }
    });

  }
}
