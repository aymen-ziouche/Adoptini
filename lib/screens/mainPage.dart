import 'package:adoptini/screens/addpetpage.dart';
import 'package:adoptini/screens/favoritespage.dart';
import 'package:adoptini/screens/homepage.dart';
import 'package:adoptini/screens/mapscreen.dart';
import 'package:adoptini/screens/profilepage.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String id = "MainPage";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _getCurrentpage(value) async {
    switch (value) {
      case 0:
        setState(() {
          _bottomNavIndex = value;
          _child = const HomePage();
        });
        break;
      case 1:
        setState(() {
          _bottomNavIndex = value;
          _child = const MapScreen();
        });
        break;
      case 2:
        setState(() {
          _bottomNavIndex = value;
          _child = const FavoritesPage();
        });
        break;
      case 3:
        setState(() {
          _bottomNavIndex = value;
          _child = ProfilePage();
        });
        break;
    }
  }

  Widget _child = const HomePage();

  var iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.mapPin,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.solidUser,
  ];

  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _child,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddPetPage.id);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.white,
        activeColor: Colors.indigo,
        inactiveColor: Colors.black38,
        height: 60,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (value) {
          _getCurrentpage(value);
        },
      ),
    );
  }
}
