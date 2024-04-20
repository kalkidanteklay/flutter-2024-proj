import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/screens/user_page.dart';
import 'package:flutter_pet_pal/presentation/screens/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignupPage(),
        // theme: ThemeData(primarySwatch: Colors.orange),
        routes: {
          '/admin': (context) => AdminPage(),
        });
  }
}
