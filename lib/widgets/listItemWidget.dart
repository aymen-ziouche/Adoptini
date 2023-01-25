import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String breed;
  final String gender;
  final String age;
  final String description;

  const ListItem(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.breed,
      required this.gender,
      required this.age,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final male = gender == 'Male' ? true : false;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Material(
          borderRadius: BorderRadius.circular(20.0),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    height: 120,
                    width: 150,
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          )
                        : const Placeholder(
                            color: Colors.white,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 26.0,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            male
                                ? FontAwesomeIcons.mars
                                : FontAwesomeIcons.venus,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        breed,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '$age years old',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: const [
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.indigo,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          // Text(
                          //   'Distance: ${pet.distanceToUser}',
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //     color:
                          //         Theme.of(context)
                          //             .primaryColor,
                          //     fontWeight:
                          //         FontWeight.w400,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
