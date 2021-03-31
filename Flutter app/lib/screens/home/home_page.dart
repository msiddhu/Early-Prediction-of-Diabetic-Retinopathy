
import 'package:VIRTUALDRKIT/screens/authenticate/sign_in.dart';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';
import 'package:VIRTUALDRKIT/screens/home/nav_drawer.dart';
import 'package:VIRTUALDRKIT/screens/home/profile_page.dart';
import 'package:VIRTUALDRKIT/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tensorflow_testing.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.init();
  }


  @override
  Widget build(BuildContext context) {
    var padd=15.0;
    var lwidth=200.0;
    var lheight=200.0;

    return Scaffold(
      backgroundColor:cColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: cColors.appbarColor,
        title: Text('DR KIT'),
        elevation: 0.0,
        actions: [
          TextButton.icon(
              onPressed: () {
       Navigator.push(
           context, MaterialPageRoute(builder: (context) => Tensor()));
              },
              icon: Icon(Icons.settings),
              label: Text('Test DR'))
        ],
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Container(
        padding: EdgeInsets.all(7),
          child:ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[

                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(color: Colors.indigo),
                  height: 60,
                  child: Text('Diabetic Retinopathy',
                    style: TextStyle(fontSize: 27),
                    textAlign:TextAlign.center,),
                ),
                SizedBox(height: 2,),

                Image.asset('assets/homeImg.png',
                    width:MediaQuery.of(context).size.width,
                    fit:BoxFit.fill
                ),


                Container(
                  decoration: BoxDecoration(color: Colors.indigo),
                  height: 50,
                  child: Text('A guide to help you understand Diabetic Retinopathy, its causes, symptoms & cures.',
                    style: TextStyle(fontSize: 20),
                    textAlign:TextAlign.center,),
                ),

                SizedBox(height: 20,),

                Container(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[





                  Column(
                      children: [
                        SizedBox(height: 10,),
                        Image.asset('assets/withDR.png',
                            width:MediaQuery.of(context).size.width/2-20,
                            height:lheight,
                            fit:BoxFit.fill
                        ),

                        Text('Vision without DR',
                          style: TextStyle(fontSize: 25,
                          ),
                        ),

                      ],
                    ),
                      SizedBox(width: 10,),
                      Column(

                        children: [
                          SizedBox(height: 10,),
                          Image.asset('assets/withoutDR.png',
                              width:MediaQuery.of(context).size.width/2-20,
                            height:lheight,
                              fit:BoxFit.fill,
                ),
                          Text("Vision with DR",
                          style: TextStyle(fontSize: 25),)
                        ],
                      ),
                      
                    ],
                  ),
                 height: lheight+50,
                  color: Colors.red,
                ),
  SizedBox(height: 30,),

Container(
  decoration: BoxDecoration(color: Colors.orange),
  height: 60,
  child: Text('Stages of Diabetic Retinopathy',style: TextStyle(fontSize: 27),textAlign:TextAlign.center,),
),


                SizedBox(
                  height: MediaQuery.of(context).size.height*0.50,

                  child: ListView(
                    padding: EdgeInsets.all(padd),
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      slide('Normal Fundus','assets/level_0.jpeg','Level 0',Colors.grey[100]),
                      slide('Moderate Nonproliferative DR','assets/level_2.jpeg','Level 1',Colors.grey[300]),
                      slide('Severe Nonproliferative DR','assets/level_3.jpeg','Level 2',Colors.grey[500]),
                      slide('proliferative DR','assets/level_4.jpeg','Level 3',Colors.grey[800]),
                    ],
                  )
                ),

              //  SizedBox(width: padd,),
              ]
          )
      ),
    );
  }





  Container slide(String title,String imgurl,String level,Color redlevel) {
   var boxheight=40.0;
   var descheight=300.0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      margin: EdgeInsets.only(bottom: 7.5),
      width: 300,
      child: Card(
        color: redlevel,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blueGrey, width: 2.5),
          borderRadius: BorderRadius.circular(15.0),
        ),

        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Text(level,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 25,
                )),


            Container(
                  height: 200,
                 width: 250,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        imgurl,
                        fit:BoxFit.fill,
                      ),
                  ),
                ),

            Text(title,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,

                )),

          ],
        ),
      ),
    );
  }
}
