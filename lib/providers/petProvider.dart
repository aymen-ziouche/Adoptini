import 'package:adoptini/modules/pet.dart';
import 'package:adoptini/modules/user.dart';
import 'package:adoptini/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PetsProvider extends ChangeNotifier {
  List<Pet> _pets = [];

  List<Pet> get pets => _pets;

  set pets(List<Pet> value) {
    _pets = value;
    notifyListeners();
  }

  Future<void> fetchPets() async {
    final firebaseService = Database();
    pets = await firebaseService.loadPets();
  }

  List<Pet> get dogs {
    return pets.where((pet) => pet.type == "Dog").toList();
  }

  List<Pet> get cats {
    return pets.where((pet) => pet.type == "Cat").toList();
  }

  List<Pet> get birds {
    return pets.where((pet) => pet.type == "Bird").toList();
  }

  List<Pet> get other {
    return pets.where((pet) => pet.type == "Other").toList();
  }

  Future<void> fetchFavorites() async {
    final firebaseService = Database();
    pets = await firebaseService.loadFavorites();
  }
}
