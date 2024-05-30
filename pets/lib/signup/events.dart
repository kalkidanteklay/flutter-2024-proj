import 'package:equatable/equatable.dart';
import 'package:pets/signup/user model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/signup/states.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignupRequested extends AuthEvent {
  final User user;

  const SignupRequested({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
