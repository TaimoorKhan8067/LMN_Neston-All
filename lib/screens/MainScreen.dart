import 'package:flutter/material.dart';
import 'package:lmn_neston/screens/DoucmentsPage.dart';
import 'package:lmn_neston/screens/Drawer.dart';
import 'package:lmn_neston/screens/FeedbackPage.dart';
import 'package:lmn_neston/screens/HomePage.dart';
import 'package:lmn_neston/screens/InvitePage.dart';
import 'package:lmn_neston/screens/ProfilePage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainPage';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Profile(),
    InvitePage(),
    DocumentsPage(),
    FeedbackPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title Here"),
        backgroundColor: Colors.teal,
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Inivte',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview_rounded),
            label: 'Docs',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_rounded),
            label: 'Feedback',
            backgroundColor: Colors.teal,
          ),
        ],
        currentIndex: _selectedIndex,
        // backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
