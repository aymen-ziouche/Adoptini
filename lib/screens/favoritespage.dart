import 'package:adoptini/providers/petProvider.dart';
import 'package:adoptini/screens/detailspage.dart';
import 'package:adoptini/widgets/listItemWidget.dart';
import 'package:adoptini/widgets/shimmerWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key}) : super(key: key);
  static String id = "FavoritesPage";

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    final petsProvider = context.read<PetsProvider>();
    petsProvider.fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.indigo,
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
                child: Consumer<PetsProvider>(
                  builder: (context, provider, child) {
                    if (provider.pets.isEmpty) {
                      return const Center(child: ShimmerWidget());
                    }
                    return ListView.builder(
                      itemCount: provider.pets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final pet = provider.pets[index];
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
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (_) => PetsProvider(),
                                    child: DetailsPage(
                                      // owner: context.read<PetsProvider>().fetchOwner(pet.ownerId),
                                      pet: pet,
                                    ),
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
    );
  }
}
