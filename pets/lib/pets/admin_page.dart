import 'package:flutter/material.dart';
import 'package:pets/widgets/admin_tabs/admin_cats_tab.dart';
import 'package:pets/widgets/admin_tabs/admin_dogs_tab.dart';
import 'package:pets/widgets/admin_tabs/admin_bunny_tab.dart';
import 'package:pets/widgets/my_tab.dart';
import 'package:pets/pets/provider.dart';
import 'package:pets/pets/repository.dart';
import 'package:pets/pets/repository impl.dart';
import 'package:pets/pets/pet_form.dart';
import 'package:pets/pets/pet_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/adoption_application/admin_list.dart';

class AdminPage extends StatefulWidget {
  final String token;
  final String userId;

  const AdminPage({required this.token, required this.userId});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late PetApiProvider petApiProvider;
  late PetRepository petRepository;

  final List<Widget> myTabs = [
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: Colors.orange[300],
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange[200],
                ),
                child: Row(
                  children: [
                    CircleAvatar(),
                    Text(
                      '   Admin',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Pet Listings'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Adoption Applications'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminListPage(
                          token: widget.token, userId: widget.userId),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 350,
                    height: 230,
                    child: Card(
                      elevation: 4.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: const DecorationImage(
                                image: AssetImage('lib/images/totals.jpg'),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                          Container(
                            width: 350,
                            height: 50,
                            child: Center(
                              child: Text(
                                'Total pets: 40',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Container(
                    width: 350,
                    height: 230,
                    child: Card(
                      elevation: 4.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 350,
                            height: 230,
                            padding: EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: const DecorationImage(
                                image: AssetImage('lib/images/Forms.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                          Container(
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color.fromARGB(255, 184, 207, 226),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Pending Approvals: 3',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Text(
              '    categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            TabBar(tabs: myTabs),
            Expanded(
              child: TabBarView(
                children: [
                  DogsTab(petRepository: petRepository),
                  CatsTab(),
                  BunnyTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[400],
          hoverColor: Colors.blue[600],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => PetBloc(petRepository),
                  child: PetFormWidget(token: widget.token),
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
