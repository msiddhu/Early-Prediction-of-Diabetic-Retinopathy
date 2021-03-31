import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';

// class DatabaseService {
//   final String uid;
//   DatabaseService({
//     this.uid,
//   });
//   final CollectionReference record = Firestore.instance.collection("records");
//   Future updateUserData(String disease, String name, int strength) async {
//     print(uid);
//     return await record.document(uid).setData({
//       'disease': disease,
//       'name': name,
//       'strength': strength,
//     });
//   }
// }


class DatabaseService {
  final String uid;
  DatabaseService({
    this.uid,
  });
  final CollectionReference record = Firestore.instance.collection("users");
  Future updateUserData(String name, String email, String uid,String photoUrl) async {
    print(uid);
    return await record.document(uid).setData({
     'photoURL':photoUrl=='null'?'https://firebasestorage.googleapis.com/v0/b/virtual-dr-kit.appspot.com/o/profilepictures%2Fuser.png?alt=media&token=cbadf871-5aa7-4ac5-9b30-85e4bac98065':photoUrl,
      'name': name,
      'email': email,
      'uid': uid,
    });
  }



}
