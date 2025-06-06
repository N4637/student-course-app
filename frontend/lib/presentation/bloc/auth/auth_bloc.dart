import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_events.dart';
import 'auth_states.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(EntryLoad()) {
    on<AppStarted>((event, emit) async {
      emit(EntryLoad());
      final hasToken = await authRepository.hasToken();
      if (hasToken) {
        emit(LoggedIn());
      } else {
        emit(LoginState());
      }
    });

    on<ShowLoginPage>((event, emit) {
      emit(LoginState());
    });

    on<ShowSignPage>((event, emit) {
      emit(SignUpState());
    });

    on<ShowHomePage>((event, emit) {
      emit(LoggedIn());
    });

    on<LoginRequest>((event, emit) async {
      emit(EntryLoad());
      try {
        final success = await authRepository.login(event.email, event.password);
        if (success) {
          emit(LoggedIn());
        } else {
          emit(LoginError("Invalid Credentials"));
        }
      } catch (e) {
        emit(LoginError("Something went wrong. Please try again."));
      }
    });

    on<SignUpReq>((event, emit) async {
      emit(EntryLoad());
      try {
        final success = await authRepository.register(
          event.name,
          event.email,
          event.password,
        );

        if (success) {
          emit(SignUpSuccess());
           
          //emit(LoginState());
        } else {
          emit(SignUpError());
        }
      } catch (e) {
        emit(SignUpError());
      }
    });

    on<LogoutEvent>((event, emit) async {
      await authRepository.deleteToken();
      emit(LogoutState());
      emit(LoginState());
    });
  }
}
