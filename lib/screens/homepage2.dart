import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/petProvider.dart';
import '../providers/userProvider.dart';
import '../widgets/ListViewWidget.dart';
import '../widgets/shimmerWidget.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});
  static String id = "HomePage2";

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
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
                  ? const Color(0xff7F7D45)
                  : const Color(0xffE2DFD0),
              elevation: .0,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  animalIcons[index],
                  size: 25.0,
                  color: selectedAnimalIconIndex == index
                      ? Colors.white
                      : const Color(0xff7F7D45),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            animalTypes[index],
            style: const TextStyle(
                color: Color(0xff7F7D45),
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lemon'),
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
      body: Container(
        color: const Color(0xffFFF9E6),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 75),
              const Text(
                "Adoptini",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff7F7D45),
                    fontSize: 31,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lemon'),
              ),
              SizedBox(
                height: 5.h,
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
    );
  }
}
