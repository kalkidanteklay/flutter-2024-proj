import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pets/widgets/button.dart';

class AllTile extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String species;
  final String image;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AllTile({
    Key? key,
    required this.name,
    required this.age,
    required this.gender,
    required this.species,
    required this.image,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // image.isNotEmpty
                Image.network(
                  image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/images/default.jpg',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    );
                  },
                )
                // :// Image.asset(
                //     'assets/images/default.png',
                //     width: double.infinity,
                //     height: 200,
                //     fit: BoxFit.fill,
                //   ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Spacer(),
              ],
            ),
            Text(
              age,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              gender,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              species,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey[800],
                    size: 20,
                  ),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey[800],
                    size: 20,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
