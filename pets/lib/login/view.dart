import 'package:flutter/material.dart';
import 'package:pets/login/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/login/repository.dart';
import 'package:pets/login/login bloc.dart';

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
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
