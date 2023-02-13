import 'package:adoptini/modules/pet.dart';
import 'package:adoptini/screens/addpetpage.dart';
import 'package:adoptini/screens/detailspage.dart';
import 'package:adoptini/screens/favoritespage.dart';
import 'package:adoptini/screens/mapscreen.dart';
import 'package:adoptini/screens/profilepage.dart';
import 'package:adoptini/services/firestore.dart';
import 'package:adoptini/widgets/listItemWidget.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _db = Database();

  int selectedAnimalIconIndex = 0;
  Widget buildAnimalIcon(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                selectedAnimalIconIndex = index;
              });
            },
            child: Material(
              color: selectedAnimalIconIndex == index
                  ? Colors.indigo
                  : Colors.white,
              elevation: 8.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  animalIcons[index],
                  size: 30.0,
                  color: selectedAnimalIconIndex == index
                      ? Colors.white
                      : Colors.indigo,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            animalTypes[index],
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  List<String> animalTypes = [
    'Dogs',
    'Cats',
    'birds',
    'other',
  ];

  List<IconData> animalIcons = [
    FontAwesomeIcons.dog,
    FontAwesomeIcons.cat,
    FontAwesomeIcons.crow,
    FontAwesomeIcons.paw,
  ];
  @override
  Widget build(BuildContext context) {
    var iconList = <IconData>[
      FontAwesomeIcons.home,
      FontAwesomeIcons.mapPin,
      FontAwesomeIcons.solidHeart,
      FontAwesomeIcons.solidUser,
    ];

    var _bottomNavIndex = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(FontAwesomeIcons.bars),
                  Column(
                    children: <Widget>[
                      Text(
                        'Location',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                          color: Colors.indigo.withOpacity(0.4),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.indigo,
                          ),
                          Text(
                            'Lyon, ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0,
                            ),
                          ),
                          Text(
                            'France',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 22.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.indigo,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  color: Colors.blue.withOpacity(0.1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 20.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const <Widget>[
                              Icon(
                                FontAwesomeIcons.search,
                                color: Colors.grey,
                              ),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(fontSize: 16.0),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: 'Search pets to adopt'),
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.filter,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120.0,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 24.0,
                              top: 8.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: animalTypes.length,
                            itemBuilder: (context, index) {
                              return buildAnimalIcon(index);
                            }),
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _db.loadPets(),
                            builder: (context, snapshot) {
                              List<Pet> pets = [];
                              if (snapshot.hasData) {
                                for (var doc in snapshot.data!.docs) {
                                  var data = doc;
                                  pets.add(
                                    Pet(
                                      ownerId: data['ownerId'],
                                      name: data['petName'],
                                      breed: data['petBreed'],
                                      gender: data['petGender'],
                                      type: data['petType'],
                                      age: data['petAge'],
                                      description: data['petDescription'],
                                      image: data['petImage'],
                                      longitude: data['longitude'],
                                      latitude: data['latitude'],
                                      favorites: data["favorites"],
                                      petId: data['petId'],
                                    ),
                                  );
                                }
                              }
                              return ListView.builder(
                                itemCount: pets.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final pet = pets[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                      right: 20.0,
                                      left: 20.0,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              pet: pet,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ListItem(
                                          imageUrl: pet.image,
                                          name: pet.name,
                                          breed: pet.breed,
                                          gender: pet.gender,
                                          age: pet.age,
                                          description: pet.description),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
        // TODO: fix routing for this section
        onTap: (value) {
          switch (value) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, MapScreen.id);
              break;
            case 2:
              Navigator.pushNamed(context, FavoritesPage.id);
              break;
            case 3:
              Navigator.pushNamed(context, ProfilePage.id);
              break;
          }
        },
      ),
    );
  }
}
