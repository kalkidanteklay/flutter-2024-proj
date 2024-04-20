import 'package:flutter/material.dart';
//import 'my_textfield.dart';

void main() {
  runApp( MaterialApp(
    home: FormScreen(),
  ));
}

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Add a new pet'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30.0),
          // height: 400,
          // width: 450,
          color: Colors.orange[200],
        child: 
      
            Container(
               margin: EdgeInsets.all(10.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add a new pet',
                style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                 TextField(
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 30)
                ),
                labelText: 'Name'
            
              ),
            ),
            SizedBox(height: 10.0),
             TextField(
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                labelText: 'Age'
            
              ),
            ),
            SizedBox(height: 10.0),
             TextField(
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                labelText: 'Species'
            
              ),
            ),
            SizedBox(height: 10.0),
             TextField(
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                labelText: 'Gender'
            
              ),
            ),
            SizedBox(height: 10.0),
            
            Icon(Icons.add_photo_alternate),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Done'),
            ),
              ]
            ))
           
          
        
      ),
      ),
    );
  }
}