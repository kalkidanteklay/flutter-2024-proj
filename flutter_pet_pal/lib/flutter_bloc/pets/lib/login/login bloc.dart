import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:pets/login/repository.dart';
import 'package:pets/login/events.dart';
import 'package:pets/login/states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await userRepository.login(event.email, event.password);
      final decodedToken = _decodeToken(token);
      final userId = decodedToken['sub'];
      final role = decodedToken['role'];

      if (userId == null || role == null) {
        throw Exception('Invalid token or missing role/user ID');
      }

      emit(Authenticated(role: role, token: token, userId: userId));
    } catch (e) {
      emit(AuthError(message: 'Failed to authenticate: ${e.toString()}'));
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
}
