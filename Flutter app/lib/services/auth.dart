import 'file:///C:/Users/msidd/Desktop/projects/VIRTUALDRKIT/lib/services/user.dart';
import 'package:VIRTUALDRKIT/screens/home/profile_page.dart';
import 'package:VIRTUALDRKIT/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:VIRTUALDRKIT/screens/home/records.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  //Displaying user obj through a fn
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change module

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register for email and password

  Future registerWithEmailAndPassword(String name,String email, String password,) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //File m = Image.file(doctor-full.png);
      await DatabaseService(uid: user.uid).updateUserData(name,email,user.uid.toString(),'null');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


   init() async {
    cUser.userRef = _db.collection('users').document((await FirebaseAuth.instance.currentUser()).uid);
    DocumentSnapshot ds= await cUser.userRef.get();
    var mp=ds.data;
    cUser.email=mp['email'];
    cUser.displayName=mp['name'];
    cUser.photoURL=mp['photoURL'];
    cUser.uid=mp['uid'];
    print(mp);
    cUser.storageRef= FirebaseStorage.instance.ref();
    print("user details initiated");
  }



  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
final AuthService _authService =new AuthService();