import 'package:VIRTUALDRKIT/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      final uid = cUser.uid;
      // Similarly we can get email as well
      final String uemail = cUser.email;
      print(uid);
      print(uemail);
    //  final String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('profilepictures/$uemail')
          .child(cUser.uid);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await (await taskSnapshot).ref.getDownloadURL();
      await DatabaseService().updateUserData(cUser.displayName, cUser.email, cUser.uid, downloadUrl);
      setState(() {
        cUser.photoURL=downloadUrl;
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }


    return Scaffold(
      backgroundColor: cColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: cColors.appbarColor,
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Profile'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Color(0xff476cfb),
                          child: ClipOval(
                            child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_image != null)
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                     cUser.photoURL,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.camera,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Color(0xff476cfb),
                        onPressed: () {
                          uploadPic(context);
                        },
                        elevation: 4.0,
                        splashColor: Colors.blueGrey,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Text(
                      "Name: ",
                      style: TextStyle(fontSize: 20, color: Colors.yellow[900]),
                    ),
                    Text(
                      cUser.displayName,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Text(
                      "Email: ",
                      style: TextStyle(fontSize: 20, color: Colors.yellow[900]),
                    ),
                    Text(
                      cUser.email,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ]),

                ],
              ),
            ),
          ),
        ),
    );
  }
}
