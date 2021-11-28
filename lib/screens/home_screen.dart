import 'package:final_submission/data/db/db_helper.dart';
import 'package:final_submission/providers/db_provider.dart';
import 'package:final_submission/screens/favorite_screen.dart';
import 'package:final_submission/screens/list_screen.dart';
import 'package:final_submission/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DatabaseProvider databaseProvider = DatabaseProvider(databaseHelper: DatabaseHelper());

  int _bottomNavIndex = 0;

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
  ];

  List<Widget> _listWidget = [
    ListPage(),
    FavoritePage(
      dbProvider: databaseProvider,
    ),
    SettingPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(
      () {
        _bottomNavIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF98bd8f),
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
