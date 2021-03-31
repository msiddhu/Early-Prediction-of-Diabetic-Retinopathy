

import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';
import 'package:VIRTUALDRKIT/services/loading.dart';

import 'nav_drawer.dart';


class RecordsPage extends StatefulWidget {


  @override
  _RecordsPageState createState() => _RecordsPageState();

}

class _RecordsPageState extends State<RecordsPage> {

  Stream blogsStream;
  bool st=false;
  Widget blogsList() {

    return Container(


      child: StreamBuilder<QuerySnapshot>(
        stream: blogsStream,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          else{
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                //
                // return BlogTile(
                //   authorname: ds.data()["authorName"],
                //   imgUrl: ds.data()["imgUrl"],
                //   title: ds.data()["title"],
                //   description: ds.data()["desc"],
                //   time: ds.data()["time"],
                //   documentId: ds.data()["documentId"],
                //   issaved: (cUser.saved_blogs).contains(ds.data()["documentId"]),
                //   likecount: ds.data()["likes_count"],
                //   isliked: like_user_ids.contains(cUser.uid),
                // );


                return Container(

                  margin: EdgeInsets.only(bottom: 10,top:10,right: 10,left: 10 ),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: cColors.buttonColor,),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("Date and Time: "+ds['date_and_time'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child:CachedNetworkImage(
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: ds['photoUrl'],
                              placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover)
                        //
                        // Image.network(allImagepaths[index],fit:BoxFit.fill),
                      ),
                      SizedBox(height: 10,),
                      Text("DR level: "+ds['dr_level'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                    ],
                  ),
                );
              },
            );

          }
        },
      ),
    );
  }

  @override
  initState()  {
    super.initState();

    getAllData().then((result){
      setState(() {
        print("sidhu");
        blogsStream=result;
        print(result);
      });
    });

  }


  Future getAllData() async{
    return (await Firestore.instance.collection('users').document(cUser.uid).collection('records').snapshots());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title:Text("Records"),
        backgroundColor: cColors.appbarColor,
           ),
      body: blogsStream!=null?
      blogsList():
      Container(),
      floatingActionButton: Container(
        //padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}

