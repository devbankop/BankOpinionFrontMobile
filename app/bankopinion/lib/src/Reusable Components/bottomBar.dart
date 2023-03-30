import 'package:bankopinion/src/pages/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/homeView.dart';
import '../pages/news.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  String? userRole;

  Future<void> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole');
    });
  }

  @override
  void initState() {
    super.initState();
    _getRole();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageHomePage(),
          ),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsView(),
          ),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfigView(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: BottomNavigationBar(
        backgroundColor: userRole == 'superAdmin'
            ? Color.fromARGB(255, 223, 116, 116)
            : const Color.fromARGB(255, 153, 116, 223),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: _currentIndex == 1 ? Colors.white : null,
            icon: const Icon(Icons.rate_review_outlined, size: 25),
            label: 'Opiniones',
          ),
          BottomNavigationBarItem(
            backgroundColor: _currentIndex == 0 ? Colors.white : null,
            icon: const Icon(Icons.newspaper, size: 25),
            label: 'Noticias',
          ),
          BottomNavigationBarItem(
            backgroundColor: _currentIndex == 2 ? Colors.white : null,
            icon: const Icon(Icons.account_circle, size: 25),
            label: 'Perfil',
          )
        ],
      ),
    );
  }
}
