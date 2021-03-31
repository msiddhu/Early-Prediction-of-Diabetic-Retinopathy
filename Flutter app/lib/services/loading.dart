import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: cColors.loadingColor,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 280.0, horizontal: 50.0),
            child: Center(
                child: Column(children: [
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.backup, size: 20.0),
                  label: Text(
                    'Loading',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              SpinKitFadingCircle(
                color: Colors.purple[900],
                size: 50.0,
              ),
            ]))));
  }
}
