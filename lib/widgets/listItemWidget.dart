

import 'package:flutter/material.dart';

Widget secondListItem(
  String imageUrl,
  String title,
  String description,
) {
  return Container(
    width: double.infinity,
    height: 120,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 80,
            width: 80,
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )
                : Placeholder(
                    color: Colors.white,
                  )),
        const SizedBox(width: 35),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
