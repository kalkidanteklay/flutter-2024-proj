import 'package:flutter/material.dart';
import 'package:pets/pets/fav_page.dart';
import 'package:pets/widgets/drawer.dart';
import 'package:pets/widgets/my_tab.dart';
import 'package:pets/widgets/tab/cat_tab.dart';
import 'package:pets/widgets/tab/dog_tab.dart';
import 'package:pets/widgets/tab/bunny_tab.dart';
import 'package:pets/widgets/my_tab.dart';
import 'package:pets/pets/provider.dart';
import 'package:pets/pets/repository.dart';
import 'package:pets/pets/repository impl.dart';
import 'package:pets/adoption_application/list.dart';
import 'package:pets/adoption_application/presentation.dart';

class UserPage extends StatefulWidget {
  final String token;
  final String userId;

  const UserPage({required this.token, required this.userId});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late PetApiProvider petApiProvider;
  late PetRepository petRepository;
  //my tabs
  final List<Widget> myTabs = const [
    MyTab(iconPath: 'lib/icons/dog.png'),
    MyTab(iconPath: 'lib/icons/smile.png'),
    MyTab(iconPath: 'lib/icons/easter-bunny.png'),
  ];

  @override
  void initState() {
    super.initState();
    petApiProvider = PetApiProvider(
      'http://localhost:3000',
      widget.token,
    );
    petRepository = PetRepositoryImpl(petApiProvider);
  }

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesPage()),
                  );
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(),
                accountName:
                    const Text('Name', style: TextStyle(color: Colors.black)),
                accountEmail: const Text('user@example.com',
                    style: TextStyle(color: Colors.black)),
                currentAccountPicture:
                    const CircleAvatar(child: Icon(Icons.person)),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/user_page');
                },
                leading: const Icon(Icons.home),
                title: const Text('HOME'),
              ),
              ListTile(
                  leading: const Icon(Icons.book_online),
                  title: const Text('FORM'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationPage(
                            token: widget.token, userId: widget.userId),
                      ),
                    );
                  }),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/fav_page');
                },
                leading: const Icon(Icons.favorite),
                title: const Text('FAVORITES'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ListPage(token: widget.token, userId: widget.userId),
                    ),
                  );
                },
                leading: const Icon(Icons.label),
                title: const Text('STATUS'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/vet_appt_page');
                },
                leading: const Icon(Icons.event),
                title: const Text('VET APPOINTMENT'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/login_page');
                },
                leading: const Icon(Icons.logout),
                title: const Text('LOGOUT'),
              ),
            ],
          ),
        ),
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
                DogsTab(petRepository: petRepository),

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
