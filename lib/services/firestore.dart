
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user's uid
  String getCurrentUserUid() {
    final uid = _auth.currentUser?.uid;
    return uid!;
  }

  // Get current user's name from Firestore using uid
  Future<String> getCurrentUserName() async {
    final uid = _auth.currentUser?.uid;
    final name = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => value['name']);
    print(name);
    return name;
  }

}
