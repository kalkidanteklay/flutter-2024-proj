import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/login/presentation.dart';
import 'package:pets/pets/user_page.dart';
import 'package:pets/signup and login/events.dart';
import 'package:pets/signup and login/states.dart';
import 'package:pets/signup/user model.dart';
import 'package:pets/signup and login/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:pets/login/login bloc.dart';
import 'package:pets/pets/user_page.dart';
import 'package:pets/pets/admin_page.dart';
//import 'package:pets/login/states.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 10),
                  // image
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 100, left: 100, bottom: 5),
                    child: Image.asset(
                      'lib/images/signup.png',
                      scale: 5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // text
                  const Text(
                    "P E T P A L    A D O P T I O N",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 25),
                  // textfield full name
                  MyTextfield(
                    controller: _fullNameController,
                    hintText: "Enter your full name",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  // textfield email
                  MyTextfield(
                    controller: _emailController,
                    hintText: "Enter your email",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  // textfield password
                  MyTextfield(
                    controller: _passwordController,
                    hintText: "Enter your password",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is SignUPAuthenticated) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: MyButton(
                        text: "Sign Up",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final user = User(
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            context
                                .read<AuthBloc>()
                                .add(SignupRequested(user: user));
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Congratulations on taking the first step towards finding your new furry friend!",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////////login page///////////////
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is Authenticated) {
            await storage.write(key: 'access_token', value: state.token);
            await storage.write(key: 'userId', value: state.userId);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login successful')),
            );

            if (state.role == 'admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AdminPage(token: state.token, userId: state.userId)),
              );
              //       builder: (context) => AdminPage(
              //           token: state.token, userId: state.userId)),
              // );
            } else if (state.role == 'user') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    // builder: (context) =>
                    //ListPage(token: state.token, userId: state.userId)),
                    builder: (context) =>
                        UserPage(token: state.token, userId: state.userId)),
                // builder: (context) => ApplicationPage(
                //     token: state.token, userId: state.userId)),
              );
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    // Image
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Image.asset('lib/images/login.png'),
                    ),
                    const SizedBox(height: 15),
                    // Welcome text
                    const Text(
                      "Hey there! Welcome back",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    // Email TextField
                    MyTextfield(
                      controller: _emailController,
                      hintText: "Enter your Email",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Password TextField
                    MyTextfield(
                      controller: _passwordController,
                      hintText: "Enter your password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Login Button
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: MyButton(
                        text: "Log in",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  LoginRequested(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final bool obscureText;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        validator: validator,
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}


////////login page////////