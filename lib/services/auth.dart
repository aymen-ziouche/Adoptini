



import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp(String email, String password, String name, File image) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final user = authResult.user;

    // Save the profile picture to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('user_profiles/${user?.uid}');
    final uploadTask = storageRef.putFile(image);
    final downloadUrl = await (await uploadTask).ref.getDownloadURL();
    
    // Save the user's information on Firestore
    await _firestore.collection('users').doc(user?.uid).set({
      'name': name,
      'email': email,
      'profile_picture': downloadUrl,
    });
    return authResult;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }
}

