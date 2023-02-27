import 'package:flutter/material.dart';



class DrawerWidget extends StatelessWidget {
  final provider;
  const DrawerWidget({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                provider.user!.profilePicture,
              ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.message_rounded,
          ),
          title: const Text('Messages'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.train,
          ),
          title: const Text('Another page'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}