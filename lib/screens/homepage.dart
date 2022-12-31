import 'package:adoptini/modules/pet.dart';
import 'package:adoptini/screens/addpetpage.dart';
import 'package:adoptini/screens/detailspage.dart';
import 'package:adoptini/services/firestore.dart';
import 'package:adoptini/widgets/listItemWidget.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _db = Database();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: _db.loadPets(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Pet> pets = [];

                    for (var doc in snapshot.data!.docs) {
                      var data = doc;
                      pets.add(
                        Pet(
                          ownerId: data['ownerId'],
                          name: data['petName'],
                          breed: data['petBreed'],
                          age: data['petAge'],
                          description: data['petDescription'],
                          image: data['petImage'],
                        ),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                pet: pets[index],
                              ),
                            ),
                          );
                        },
                        child: secondListItem(pets[index].image,
                            pets[index].name, pets[index].description),
                      ),
                      itemCount: pets.length,
                    );
                  } else {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                }),
          ),
        ],
      ),
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
        backgroundColor: Colors.black38,
        activeColor: Colors.indigo,
        inactiveColor: Colors.white,
        height: 60,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    ));
  }
}
