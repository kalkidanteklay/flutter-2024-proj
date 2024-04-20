import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/widgets/drawer.dart';
import 'package:flutter_pet_pal/presentation/widgets/my_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/tab/bunny_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/tab/cat_tab.dart';
import 'package:flutter_pet_pal/presentation/widgets/tab/dog_tab.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //my tabs
  List<Widget> myTabs = const [
    MyTab(iconPath: 'lib/icons/dog.png'),
    MyTab(iconPath: 'lib/icons/smile.png'),
    MyTab(iconPath: 'lib/icons/easter-bunny.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          elevation: 0,
          title: Center(
              child: Text(
            'P E T P A L',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.grey[800],
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/fav_page'); //opens fav page
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        
        body: Column(
          children: [
            //find your bestfriend!
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Find your new Bestfriend!!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(
              height: 14,
            ),

            //tab bar
            TabBar(tabs: myTabs),

            //tab bar view
            Expanded(
                child: TabBarView(
              children: [
                //dogs page
                DogsTab(),

                //cats page
                CatsTab(),

                //bunny page
                BunnyTab(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
