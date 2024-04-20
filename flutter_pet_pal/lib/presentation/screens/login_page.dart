import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/widgets/button.dart';
import 'package:flutter_pet_pal/presentation/widgets/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signuserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 15),
                //image
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, right: 100, left: 100, bottom: 5),
                  child: Image.asset('lib/images/login.png'),
                ),

                //text
                const SizedBox(height: 15),

                const Text(
                  "Hey there! Welcome back",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(
                  height: 15,
                ),

                //textfield email
                MyTextfield(
                  controller: emailController,
                  hintText: "Enter your Email",
                  obsecureText: false,
                ),

                const SizedBox(
                  height: 15,
                ),
                //textfield password
                MyTextfield(
                  controller: passwordController,
                  hintText: "Enter your password",
                  obsecureText: true,
                ),

                const SizedBox(
                  height: 15,
                ),
                //button(sign in)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: MyButton(
                    text: "Log in", //ontap: signuserIn
                    onTap: () {
                      Navigator.pushNamed(context, '/signup_page');
                    },
                  ),
                ),

                const SizedBox(height: 10),
                //text(already have an account login)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    //sign up clickable
                    const SizedBox(width: 4),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
