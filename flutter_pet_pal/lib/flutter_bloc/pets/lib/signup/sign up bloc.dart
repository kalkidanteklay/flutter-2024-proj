import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pets/signup/repository.dart';
import 'package:pets/signup/events.dart';
import 'package:pets/signup/states.dart';
import 'dart:convert';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    //on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LoggedOut>(_onLoggedOut);
  }

  // void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     final token = await userRepository.login(event.email, event.password);
  //     final decodedToken = _decodeToken(token);
  //     final userId = decodedToken['sub'];
  //     final role = decodedToken['role'];

  //     if (userId == null || role == null) {
  //       throw Exception('Invalid token or missing role/user ID');
  //     }

  //     emit(Authenticated(role: role, token: token, userId: userId));
  //   } catch (e) {
  //     emit(AuthError(message: 'Failed to authenticate: ${e.toString()}'));
  //   }
  // }

  // void _onSignupRequested(
  //     SignupRequested event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   {
  //     final token = await userRepository.signup(
  //       event.user.email,
  //       event.user.password,
  //       event.user.fullName,
  //     );
  //   final decodedToken = _decodeToken(token);
  //   final userId = decodedToken['sub'];
  //   final role = decodedToken['role'];

  //   if (userId == null || role == null) {
  //     throw Exception('Invalid token or missing role/user ID');
  //   }

  //   emit(Authenticated(role: role, token: token, userId: userId));
  //   } catch (e) {
  //   emit(AuthError(message: 'Failed to sign up'));
  void _onSignupRequested(
      SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await userRepository.signup(
        event.user.email,
        event.user.password,
        event.user.fullName,
      );
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(message: 'Failed to sign up'));
    }
  }
}

void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
  emit(AuthInitial());
}

Map<String, dynamic> _decodeToken(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }
  final payload = parts[1];
  final normalized = base64Url.normalize(payload);
  final decoded = utf8.decode(base64Url.decode(normalized));
  return jsonDecode(decoded);
}
