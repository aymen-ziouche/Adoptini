import 'package:adoptini/providers/petProvider.dart';
import 'package:adoptini/providers/userProvider.dart';
import 'package:adoptini/widgets/DrawerWidget.dart';
import 'package:adoptini/widgets/ListViewWidget.dart';
import 'package:adoptini/widgets/shimmerWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    userProvider.fetchUser();
    final petsProvider = context.read<PetsProvider>();
    petsProvider.fetchPets();
  }

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
    'Birds',
    'Other',
  ];

  List<IconData> animalIcons = [
    FontAwesomeIcons.dog,
    FontAwesomeIcons.cat,
    FontAwesomeIcons.crow,
    FontAwesomeIcons.paw,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            if (provider.user == null) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.indigo,
                strokeWidth: 5,
              ));
            }
            return DrawerWidget(
              provider: provider,
            );
          },
        ),
      ),
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
              child: Consumer<UserProvider>(
                builder: (context, provider, child) {
                  if (provider.user == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.indigo,
                        strokeWidth: 5,
                      ),
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Icon(FontAwesomeIcons.bars)),
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
                            children: [
                              const Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.indigo,
                              ),
                              Text(
                                "${provider.user!.city}, ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                ),
                              ),
                              Text(
                                provider.user!.country,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          provider.user!.profilePicture,
                        ),
                      ),
                    ],
                  );
                },
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
                                FontAwesomeIcons.magnifyingGlass,
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
                          child: Consumer<PetsProvider>(
                            builder: (context, provider, child) {
                              if (provider.pets.isEmpty) {
                                return const Center(child: ShimmerWidget());
                              }
                              if (selectedAnimalIconIndex == 0) {
                                if (provider.dogs.isNotEmpty) {
                                  return ListViewWidget(
                                    provider: provider.dogs,
                                  );
                                } else {
                                  return const Center(
                                      child: Text(
                                    "No pets here",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ));
                                }
                              } else if (selectedAnimalIconIndex == 1) {
                                if (provider.cats.isNotEmpty) {
                                  return ListViewWidget(
                                    provider: provider.cats,
                                  );
                                } else {
                                  return const Center(
                                      child: Text(
                                    "No pets here",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ));
                                }
                              } else if (selectedAnimalIconIndex == 2) {
                                if (provider.birds.isNotEmpty) {
                                  return ListViewWidget(
                                    provider: provider.birds,
                                  );
                                } else {
                                  return const Center(
                                      child: Text(
                                    "No pets here",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ));
                                }
                              } else if (selectedAnimalIconIndex == 3) {
                                if (provider.other.isNotEmpty) {
                                  return ListViewWidget(
                                    provider: provider.other,
                                  );
                                } else {
                                  return const Center(
                                      child: Text(
                                    "No pets here",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ));
                                }
                              }
                              return const Text('No Data');
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
    );
  }
}
