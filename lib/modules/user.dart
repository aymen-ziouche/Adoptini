import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String profilePicture;
  final String latitude;
  final String longitude;
  late String city;
  late String country;

  User({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.profilePicture = '',
    this.latitude = '',
    this.longitude = '',
    this.city = '',
    this.country = '',
  });

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return User(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      profilePicture: data['profile_picture'],
      latitude: data['latitude'].toString(),
      longitude: data['longitude'].toString(),
    );
  }
}

 // TODO: here's the accounts


// aymen.zch23@gmail.com ===> test1234
// test@test.com ===> test1234
