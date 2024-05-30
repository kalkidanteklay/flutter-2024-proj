import 'package:flutter/material.dart';
import 'package:pets/widgets/all_tiles.dart';

class BunnyTab extends StatelessWidget {
  // const BunnyTab({super.key});
  List dogsAvailable = [
    //[image, name, age, gender, species]
    [
      'lib/images/bunny1.jpeg',
      "Name: Cotton",
      'Age: 1',
      'Gender: Male',
      'Species: Holland Lop',
    ],
    [
      'lib/images/bunny2.jpeg',
      "Name: Daisy",
      'Age: 2',
      'Gender: Female',
      'Species: Netherland Dwarf',
    ],
    [
      'lib/images/bunny3.jpeg',
      "Name: Thumper",
      'Age: 3',
      'Gender: Male',
      'Species: Mini Rex',
    ],
    [
      'lib/images/bunny4.jpeg',
      "Name: Clover",
      'Age: 2.5',
      'Gender: Female',
      'Species: Lionhead',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      itemCount: dogsAvailable.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.5),
      itemBuilder: (context, index) {
        return AllTile(
          imagePath: dogsAvailable[index][0],
          name: dogsAvailable[index][1],
          age: dogsAvailable[index][2],
          gender: dogsAvailable[index][3],
          species: dogsAvailable[index][4],
        );
      },
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Container(
//     child: Center(child: Text('Bunnies Tab')),
//   );
// }
