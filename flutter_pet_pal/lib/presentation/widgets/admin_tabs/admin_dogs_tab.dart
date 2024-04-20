import 'package:flutter/material.dart';
//import '../all_tiles.dart';
import '../admin_tiles.dart';

class DogsTab extends StatelessWidget {
  List dogsAvailable = [
    //[image, name, age, gender, species]
    [
      'lib/images/dog1.jpeg',
      "Name: Max",
      'Age: 3',
      'Gender: Male',
      'Species: Labrador Retriever',
    ],
    [
      'lib/images/dog2.jpeg',
      "Name :Luna",
      'Age: 2',
      'Gender: Female',
      'Species: German Shepherd',
    ],
    [
      'lib/images/dog3.jpeg',
      "Name: Bobby",
      'Age: 5',
      'Gender: Male',
      'Species: Golden Retriever',
    ],
    [
      'lib/images/dog4.jpeg',
      "Name: Daisy",
      'Age: 1',
      'Gender: Female',
      'Species: Bulldog',
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
