import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:VIRTUALDRKIT/services/auth.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';

class Register extends StatefulWidget {
  static List a = [];
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String name='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        //backgroundColor: Colors.blue[300],
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
                label: Text('sign in')),
          ],
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/doctor-full2.png'),
                      fit: BoxFit.cover)),
              padding: EdgeInsets.symmetric(vertical: 280.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60.0),

                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon:
                          Icon(Icons.person, color: Colors.purple),
                          hintText: 'Name',
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
                      val.isEmpty ? 'Enter an Name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),

                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.purple),
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
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
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
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(name,email, password);
                            if (result == null) {
                              setState(
                                  () => error = 'Please provide a valid email');
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
            ),
          ])
        ]));
  }
}
