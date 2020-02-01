import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('email@email.com'),
            accountName: Text('user name'),
            currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/', arguments: 2);
                },
                child: CircleAvatar(child: Text('un'))),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/', arguments: null);
            },
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text('Home'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/', arguments: 1);
            },
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue,
            ),
            title: Text('Diat & Goals'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/', arguments: 2);
            },
            leading: Icon(
              Icons.account_circle,
              color: Colors.blue,
            ),
            title: Text('Profile'),
          ),
          ListTile(
            onTap: () {
              // TODO Settings page
              //Navigator.pushReplacementNamed(context, '---', arguments: null);
            },
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
