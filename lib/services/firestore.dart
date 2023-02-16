import 'dart:io';

import 'package:adoptini/modules/pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<List<Pet>> loadPets() async {
    try {
      final petsSnapshot =
          await FirebaseFirestore.instance.collection('pets').get();
      return petsSnapshot.docs
          .map((doc) => Pet(
                name: doc.get('petName'),
                breed: doc.get('petBreed'),
                age: doc.get('petAge'),
                description: doc.get('petDescription'),
                favorites: doc.get('favorites'),
                gender: doc.get('petGender'),
                size: doc.get('petSize'),
                image: doc.get('petImage'),
                latitude: doc.get('latitude'),
                longitude: doc.get('longitude'),
                ownerId: doc.get('ownerId'),
                petId: doc.get('petId'),
                type: doc.get('petType'),
              ))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
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

  Future<List<Pet>> loadFavorites() async {
    final user = _auth.currentUser;

    try {
      final petsSnapshot =
          await FirebaseFirestore.instance.collection('pets').where("favorites", arrayContains:user?.uid).get();
      return petsSnapshot.docs
          .map((doc) => Pet(
                name: doc.get('petName'),
                breed: doc.get('petBreed'),
                age: doc.get('petAge'),
                description: doc.get('petDescription'),
                favorites: doc.get('favorites'),
                gender: doc.get('petGender'),
                size: doc.get('petSize'),
                image: doc.get('petImage'),
                latitude: doc.get('latitude'),
                longitude: doc.get('longitude'),
                ownerId: doc.get('ownerId'),
                petId: doc.get('petId'),
                type: doc.get('petType'),
              ))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
