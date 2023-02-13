import 'package:adoptini/modules/pet.dart';
import 'package:adoptini/screens/detailspage.dart';
import 'package:adoptini/services/firestore.dart';
import 'package:adoptini/widgets/listItemWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key}) : super(key: key);
  static String id = "FavoritesPage";

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    var _db = Database();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Your favorites:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Colors.indigo.withOpacity(0.7),
                ),
              ),
            ),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _db.loadFavorites(),
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

            // TODO: I GOT NO IDEA WHAT I"M DOING HERE.
            // FutureBuilder(
            //   future: _db.loadFavorites(),
            //   builder: (context, snapshot) {
            //     List<Pet> pets = [];
            // if (snapshot!= null) {
            //               for (var doc in snapshot) {
            //                 var data = doc;
            //                 pets.add(
            //                   Pet(
            //                     petId: data["petId"],
            //                     ownerId: data['ownerId'],
            //                     name: data['petName'],
            //                     breed: data['petBreed'],
            //                     gender: data['petGender'],
            //                     age: data['petAge'],
            //                     description: data['petDescription'],
            //                     image: data['petImage'],
            //                     longitude: data['longitude'],
            //                     latitude: data['latitude'],
            //                   ),
            //                 );
            //               }
            //             }
            // return Container();
            // },
            // ),
          ],
        ),
      ),
    );
  }
}
