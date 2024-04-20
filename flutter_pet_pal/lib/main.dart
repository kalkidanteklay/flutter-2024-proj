import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/screens/admin.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminPage(),
        // theme: ThemeData(primarySwatch: Colors.orange),
        routes: {
          '/admin': (context) => AdminPage(),
        });
  }
}
