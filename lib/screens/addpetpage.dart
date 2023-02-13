import 'dart:io';

import 'package:adoptini/screens/homepage.dart';
import 'package:adoptini/services/auth.dart';
import 'package:adoptini/services/firestore.dart';
import 'package:adoptini/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);
  static String id = "AddPetPage";

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _petName = TextEditingController();
  final _petBreed = TextEditingController();
  final _petAge = TextEditingController();
  final _petDescription = TextEditingController();
  late File _petImage = File('');
  final _db = Database();
  final _auth = Auth();

  String _petGender = 'Male';

  // List of items in our dropdown menu
  var genders = [
    'Male',
    'Female',
  ];

  String _petSize = 'Medium';

  // List of items in our dropdown menu
  var sizes = [
    'Small',
    'Medium',
    'Large',
  ];

  String _petType = 'Dog';

  // List of items in our dropdown menu
  var types = [
    'Dog',
    'Cat',
    'Bird',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 70.0),
                Center(
                  child: InkWell(
                    onTap: () async {
                      //Add image picker

                      final pickedFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          _petImage = File(pickedFile.path);
                        });
                      } else {
                        print('No image selected.');
                      }
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.indigo,
                      radius: 70,
                      child: Icon(
                        Icons.pets,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _petName,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter the pet\'s name!' : null,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter hte pet\'s name!',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _petDescription,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                  validator: (val) => val!.isEmpty
                      ? 'Please enter the pet\'s description!'
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter hte pet\'s description!',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _petBreed,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter the pet\'s breed!' : null,
                  decoration: const InputDecoration(
                    labelText: 'Breed',
                    hintText: 'Enter hte pet\'s breed!',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _petAge,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter the pet\'s age!' : null,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    hintText: 'Enter hte pet\'s age!',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Gender",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        DropdownButton(
                          value: _petGender,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: genders.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _petGender = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Size',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        DropdownButton(
                          value: _petSize,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: sizes.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _petSize = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Type',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        DropdownButton(
                          value: _petType,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: types.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _petType = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                MainButton(
                  text: "Add pet",
                  hasCircularBorder: true,
                  onTap: () async {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      try {
                        final uploadresult = await _db.savePetInfo(
                            petName: _petName.text,
                            petDescription: _petDescription.text,
                            petBreed: _petBreed.text,
                            petAge: _petAge.text,
                            petGender: _petGender,
                            petSize: _petSize,
                            petImage: _petImage,
                            petType: _petType);
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString(),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
