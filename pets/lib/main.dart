import 'package:flutter/material.dart';
import 'package:pets/signup and login/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/signup and login/repository.dart';
import 'package:pets/signup and login/bloc.dart';
//import 'package:pets/login/presentation.dart';
import 'package:pets/pets/user_page.dart';
import 'package:pets/signup and login/bloc.dart';
import 'package:pets/signup and login/states.dart';
import 'package:pets/signup/user model.dart';
//import 'package:pets/signup/sign up bloc.dart';

void main() {
  final userRepository = UserRepository(baseUrl: 'http://localhost:3000');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(userRepository: userRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigate to the login screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        } else if (state is AuthError) {
          // Handle signup error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: MaterialApp(
        title: 'Pet Pal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignupPage(),
      ),
    );
  }
}
