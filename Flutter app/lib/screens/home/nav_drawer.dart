import 'package:VIRTUALDRKIT/screens/home/profile_page.dart';
import 'package:VIRTUALDRKIT/screens/home/chatbot.dart';
import 'package:VIRTUALDRKIT/services/auth.dart';
import 'package:flutter/material.dart';

import 'records_page.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key key}) : super(key: key);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("assets/doctor2.jpg"),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "HOME",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "VIRTUAL DR KIT",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("Your Profile"),
      ),

      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RecordsPage()));
        },
        leading: Icon(
          Icons.inbox,
          color: Colors.black,
        ),
        title: Text("Your Records"),
      ),

      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatBot()));
        },
        leading: Icon(
          Icons.assessment,
          color: Colors.black,
        ),
        title: Text("HelpDesk"),
      ),

      ListTile(
        onTap: () async {
          await _auth.signOut();
        },
        leading: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        title: Text("Logout"),
      ),
    ]);
  }
}
