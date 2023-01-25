import 'dart:io';

import 'package:adoptini/screens/homepage.dart';
import 'package:adoptini/screens/signinpage.dart';
import 'package:adoptini/services/auth.dart';
import 'package:adoptini/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);
  static String id = "SignupPage";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _auth = Auth();
  late File _image = File('');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color(0xff827397),
                    Theme.of(context).primaryColor,
                  ],
                ),
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 70.0),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            //Add image picker

                            final pickedFile = await ImagePicker().getImage(
                              source: ImageSource.gallery,
                            );
                            if (pickedFile != null) {
                              print(pickedFile.path);
                              setState(() {
                                _image = File(pickedFile.path);
                              });
                            } else {
                              print('No image selected.');
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 70,
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 34.0),
                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your name!' : null,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your Name!',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 34.0),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your email!' : null,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email!',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 34.0),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your password!' : null,
                        onChanged: (value) {
                          print(value);
                        },
                        obscureText: true,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your pasword!',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, SigninPage.id);
                          },
                        ),
                      ),
                      const SizedBox(height: 70.0),
                      MainButton(
                        text: "Register",
                        hasCircularBorder: true,
                        onTap: () async {
                          if (_globalKey.currentState!.validate()) {
                            _globalKey.currentState!.save();
                            try {
                              final authresult = await _auth.signUp(
                                _emailController.text,
                                _passwordController.text,
                                _nameController.text,
                                _image,
                              );
                              Navigator.pushReplacementNamed(
                                  context, HomePage.id);
                              print(authresult.user!.uid);
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
            ),
          ),
        ),
      ],
    );
  }
}
