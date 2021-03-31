import 'file:///C:/Users/msidd/Desktop/projects/VIRTUALDRKIT/lib/services/user.dart';
import 'package:VIRTUALDRKIT/screens/wrapper.dart';
import 'package:VIRTUALDRKIT/services/auth.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<User>.value(
        value: AuthService().user,
        //child: StreamProvider(
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
