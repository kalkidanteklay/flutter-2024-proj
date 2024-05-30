import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange[100],
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
            onTap: () {
              Navigator.pushNamed(context, '/form_page');
            },
            leading: const Icon(Icons.book_online),
            title: const Text('FORM'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/fav_page');
            },
            leading: const Icon(Icons.favorite),
            title: const Text('FAVORITES'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/status_page');
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
    );
  }
}
