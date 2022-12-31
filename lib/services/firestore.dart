import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // save pets info to firestore
  Future<void> savePetInfo(
      // String petName,
      // String petBreed,
      // String petGender,
      // String petAge,
      // String petSize,
      // String petDescription,
      // File petImage,
      {required String petName,
      required String petBreed,
      required String petGender,
      required String petAge,
      required String petSize,
      required String petDescription,
      required File petImage}) async {
    final user = _auth.currentUser;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('pet_images/${DateTime.now().toIso8601String()}}');
    final uploadTask = storageRef.putFile(petImage);
    final downloadUrl = await (await uploadTask).ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('pets').doc().set({
      'ownerId': user?.uid,
      'petName': petName,
      'petBreed': petBreed,
      'petGender': petGender,
      'petAge': petAge,
      'petSize': petSize,
      'petDescription': petDescription,
      'petImage': downloadUrl,
    });
  }

  Stream<QuerySnapshot> loadPets() {
    return FirebaseFirestore.instance.collection('pets').snapshots();
  }
}
