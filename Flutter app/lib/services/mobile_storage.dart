import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// class FireStorageService extends ChangeNotifier {
//   // ignore: unused_element
//   FireStorageService._();
//   FireStorageService();
//
//   static Future<dynamic> loadFromStorage(String image) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     FirebaseUser user = await _auth.currentUser();
//     String uemail = user.email;
//     return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
//   }
// }
