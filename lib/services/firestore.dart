import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String docId = FirebaseFirestore.instance.collection("pets").doc().id;
  // save pets info to firestore
  Future<void> savePetInfo({
    required String petName,
    required String petBreed,
    required String petGender,
    required String petAge,
    required String petSize,
    required String petType,
    required String petDescription,
    required File petImage,
  }) async {
    final user = _auth.currentUser;

    final permission = await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude;
    final longitude = position.longitude;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('pet_images/${DateTime.now().toIso8601String()}}');
    final uploadTask = storageRef.putFile(petImage);
    final downloadUrl = await (await uploadTask).ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('pets').doc().set({
      'ownerId': user?.uid,
      'petId': docId,
      'petName': petName,
      'petBreed': petBreed,
      'petGender': petGender,
      'petAge': petAge,
      'petSize': petSize,
      'petType': petType,
      'petDescription': petDescription,
      'petImage': downloadUrl,
      'longitude': longitude,
      'latitude': latitude,
      'favorites': [],
    });
  }

  Stream<QuerySnapshot> loadPets() {
    return FirebaseFirestore.instance.collection('pets').snapshots();
  }

  Future<void> addFavorites(String petId) async {
    final user = _auth.currentUser;
    String petDocId = '';

    await FirebaseFirestore.instance
        .collection('pets')
        .where('petId', isEqualTo: petId)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        petDocId = doc.reference.id;
        print(petDocId);
      }
    });

    return FirebaseFirestore.instance.collection('pets').doc(petDocId).update({
      "favorites": FieldValue.arrayUnion([user?.uid]),
    });
  }

  // TODO: I need to get the the document id to use it here below

  Stream<QuerySnapshot> loadFavorites() {
    final user = _auth.currentUser;
    return FirebaseFirestore.instance
        .collection('pets')
        .where('favorites', arrayContains: user?.uid)
        .snapshots();
  }
}
