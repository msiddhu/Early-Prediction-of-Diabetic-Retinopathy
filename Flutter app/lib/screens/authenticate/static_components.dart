import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class cUser{
  static var displayName;
  static var uid;
  static var email;
  static DocumentReference userRef;
  static var photoURL;
  static StorageReference storageRef;
}

class cColors{
  static bool darkmode=false;
  static var appbarColor=Colors.redAccent;
  static var backgroundColor=Colors.blueGrey;
  static var buttonColor=Colors.green;
  static var loadingColor=Colors.cyan;
  
}