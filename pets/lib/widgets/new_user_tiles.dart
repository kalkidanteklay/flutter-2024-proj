import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/widgets/button.dart';

class AllTile extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String species;
  final String image;

  const AllTile(
      {super.key,
      required this.name,
      required this.age,
      required this.gender,
      required this.species,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.orange[200], borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Image.asset(
                'lib/images/default.jpg',
                width: double.infinity,
                //image,
                height: 200,
                fit: BoxFit.fill,
              ),
              Positioned(
                  bottom: 2,
                  left: 3,
                  right: 3,
                  child: MyButton(
                    text: 'Adopt Me',
                    onTap: () {
                      Navigator.pushNamed(context, '/form_page');
                    },
                    height: 40,
                    width: 60,
                    myColor: Color.fromRGBO(255, 184, 77, 0.525),
                  ))
            ]),

            //name
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey[800],
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fav_page'); //opens fav page
                  },
                ),
              ],
            ),

            //age

            Text(
              age,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            //gender

            Text(
              gender,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            //species

            Text(
              species,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            //button
          ],
        ),
      ),
    );
  }
}
