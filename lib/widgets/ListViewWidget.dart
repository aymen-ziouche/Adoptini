import 'package:adoptini/providers/petProvider.dart';
import 'package:adoptini/screens/detailspage.dart';
import 'package:adoptini/widgets/listItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewWidget extends StatelessWidget {
  final provider;
  const ListViewWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: provider.length,
      itemBuilder: (BuildContext context, int index) {
        final pet = provider[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => PetsProvider(),
                  child: DetailsPage(
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
        );
      },
    );
  }
}
