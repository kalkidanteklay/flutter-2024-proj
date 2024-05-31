import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/login/presentation.dart';
import 'package:pets/pets/user_page.dart';
import 'package:pets/signup/events.dart';
import 'package:pets/signup/states.dart';
import 'package:pets/signup/user model.dart';
import 'package:pets/signup/sign up bloc.dart';

// void main() {
//   final userRepository = UserRepository(baseUrl: 'https://localhost:3000');
//   runApp(MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthBloc>(
//           create: (context) => AuthBloc(userRepository: userRepository),
//         ),],
//         child: const SignupPage(),
//     ),
//   );
// }

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
                          padding: const EdgeInsets.only(
                              right: 100, left: 100, bottom: 5),
                          child: Image.asset(
                            'lib/images/signup.png',
                            scale: 5,
                          ),
                        ),

                        const SizedBox(height: 20),
                        // text
                        const Text(
                          "P E T P A L    A D O P T I O N",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
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

                        // BlocListener<AuthBloc, AuthState>(
                        //   listener: (context, state) {
                        //     if (state is Authenticated) {
                        //      // Navigator.pushReplacement(
                        //         //context,
                        //         //MaterialPageRoute(
                        //           ///builder: (context) => LoginScreen(),
                        //         //),
                        //       );
                        //     } else if (state is AuthError) {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(content: Text(state.message)),
                        //       );
                        //     }
                        //   },
                        // child:
                        Padding(
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

                        const SizedBox(height: 7),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "Congratulations on taking the first step towards finding your new furry friend!",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ]))),
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
