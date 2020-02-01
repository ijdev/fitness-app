import 'package:flutter/material.dart';
import 'package:home_workout/screens/diat_screen.dart';
import 'package:home_workout/screens/home_screen.dart';
import 'package:home_workout/screens/profile_Screen.dart';
import 'package:home_workout/widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage = 0;

  void _changePage(index) {
    setState(() {
      _selectedPage = index;
    });
  }

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    int profileIndex = ModalRoute.of(context).settings.arguments as int;
    if (profileIndex != null && flag) {
      _changePage(profileIndex);
      flag = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('IFitness'),
      ),
      drawer: AppDrawer(),
      body: [
        MainScreen(),
        DiatScreen(),
        ProfileScreen(),
      ].elementAt(_selectedPage),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedPage,
        selectedItemColor: Colors.lightBlue,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black54,
        onTap: (index) => _changePage(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), title: Text('Diat')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
      ),
    );
  }
}
