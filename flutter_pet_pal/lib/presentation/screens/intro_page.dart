// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_pet_pal/presentation/widgets/button.dart';
// import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 25,
            ),
            //shop name
            Text(
              "PET PAL",
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),

            const SizedBox(
              height: 15,
            ),

            //image
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("lib/images/pet-shop.png"),
            ),

            const SizedBox(
              height: 12,
            ),

            //title
            Text(
              "FIND YOUR FURRY FRIEND!",
              style: TextStyle(fontSize: 38, color: Colors.black),
            ),

            const SizedBox(
              height: 10,
            ),

            //subtitle
            Text(
              "Whether you're looking for a playful puppy, a cuddly kitten, or a loyal companion, we've got a wide selection of adorable pets waiting to meet you.",
              style: TextStyle(color: Colors.black, fontSize: 16, height: 2),
            ),

            const SizedBox(
              height: 15,
            ),

            //get started
            MyButton(
              text: "Get Started",
              onTap: () {
                Navigator.pushNamed(context, '/login_page');
              },
            )
          ],
        ),
      ),
    );
  }
}
