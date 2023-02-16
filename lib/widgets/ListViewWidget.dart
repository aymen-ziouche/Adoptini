import 'package:adoptini/screens/detailspage.dart';
import 'package:adoptini/widgets/listItemWidget.dart';
import 'package:flutter/material.dart';



class ListViewWidget extends StatelessWidget {
  final provider;
  const ListViewWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: provider.length,
      itemBuilder: (BuildContext context, int index) {
        final pet = provider[index];
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
  }
}