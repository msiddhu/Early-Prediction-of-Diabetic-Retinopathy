import 'package:VIRTUALDRKIT/services/auth.dart';
import 'file:///C:/Users/msidd/Desktop/projects/VIRTUALDRKIT/lib/services/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  dynamic result;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //backgroundColor: Colors.brown[100],
            //resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: cColors.appbarColor,
              elevation: 0.0,
              title: Text(
                'VIRTUAL DR KIT',
                style: TextStyle(color: cColors.buttonColor),
              ),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register')),
              ],
            ),
            body: ListView(children: [
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/doctor-full2.png'),
                          fit: BoxFit.cover)),
                  padding:
                      EdgeInsets.symmetric(vertical: 280.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[


                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon:
                              Icon(Icons.email, color: Colors.purple),
                              hintText: 'Email',
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue[900],
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0))),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink,
                                    width: 2.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              )),
                          validator: (val) =>
                          val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),

                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.redAccent),
                              //icon: Icon(Icons.email, color: Colors.white),
                              hintText: 'Password',
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue[900],
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0))),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink,
                                    width: 2.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              )),
                          obscureText: true,
                          validator: (val) =>
                              val.length < 6 ? 'Enter 6+ chars ' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Colors.orangeAccent[400],
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                result = await _auth.signInWithEmailAndPassword(
                                    email, password);
                                print(" The user is $result.uid");

                                if (result == null) {
                                  setState(() {
                                    error = 'Please provide a valid email';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(
                              color: Colors.orangeAccent[400], fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ]));
  }
}
