import 'package:adoptini/services/firestore.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

final _backend = Firestore();
final uid = _backend.getCurrentUserUid();

@override
void initState() {
  _backend.getCurrentUserName();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var iconList = <IconData>[
      Icons.home,
      Icons.search,
      Icons.favorite,
      Icons.person,
    ];
    var _bottomNavIndex = 0;
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RotatedBox(
                  quarterTurns: -135,
                  child: Icon(
                    Icons.bar_chart_rounded,
                    size: 28,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(
                    child: Row(
                  children: const [
                    Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 18,
                    ),
                  ],
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.black38,
        activeColor: Colors.indigo,
        inactiveColor: Colors.white,
        height: 60,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    ));
  }
}
