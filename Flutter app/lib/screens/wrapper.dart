import 'file:///C:/Users/msidd/Desktop/projects/VIRTUALDRKIT/lib/services/user.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/authenticate.dart';
import 'package:VIRTUALDRKIT/screens/home/profile_page.dart';
import 'package:VIRTUALDRKIT/screens/home/home_page.dart';
import 'package:VIRTUALDRKIT/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if (user == null)
      return Authenticate();
    else{


      return Home();}
  }
}
