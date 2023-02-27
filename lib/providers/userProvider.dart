import 'package:adoptini/modules/user.dart';
import 'package:adoptini/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  User? _user;

  User? get user => _user;

  String userid = Auth().currentUser!.uid;

  Future<void> fetchUser() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    _user = User.fromFirestore(snapshot);

    final dio = Dio();

    Future<String> getLocationFromLatLng() async {
      final lat = _user!.latitude;
      final lng = _user!.longitude;
      final response = await dio.get(
          'http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lng&appid=2754c0a345aa1a5bc62b0fd31357089b');

      if (response.statusCode == 200) {
        if (response.data != null) {
          String city = response.data[0]['state'];
          String country = response.data[0]['country'];
          _user!.city = city;
          _user!.country = country;
        }
        return 'success';
      } else {
        return 'error';
      }
    }

    await getLocationFromLatLng();
    notifyListeners();
  }
}
