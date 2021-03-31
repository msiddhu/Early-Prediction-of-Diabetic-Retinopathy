import 'dart:io';
import 'package:VIRTUALDRKIT/screens/authenticate/static_components.dart';
import 'package:VIRTUALDRKIT/screens/home/pdf_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:image/image.dart' as brendanImage;
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:tflite/tflite.dart';

class Tensor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Tensorflow",
      home: DR(),
    );
  }

}




class DR extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _DRstate();
  }
}

class _DRstate extends State<DR> {
  final doc = pdf.Document();
  List _outputs;
  int level;
  File _image;
  bool _loading = false;
  bool _pickImage=false;
  String imgName;
  final heading = "DR Prescription Data";
  PdfImage pdfimage;
  List<String> descLevel=[
    "You are free from DR",
    "You are free from DR",
    "You are free from DR",
    "You are free from DR",
    "You are free from DR",
  ];
  String description;
  String fullpath="null";

  StorageReference firebaseStorageRef;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/drd_model.tflite",
      //model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    print(output);
    setState(() {
      _loading = false;
      _outputs = output;
    });
    return output;
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value),
      duration: Duration(seconds: 3),
        backgroundColor: cColors.buttonColor,
    ));
  }
  pickImage() async{
    var image;
    if(_pickImage){
    image=await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth: 512,maxHeight: 512);
    }
    else{
      image = await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 512,maxHeight: 512);
    }

    final FirebaseUser user = await _auth.currentUser();
    final String uemail=user.email;
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    var out=await classifyImage(_image);
    String _x = out[0]["label"] as String;
    print('the output is:'+_x);
    var currDt = DateTime.now();
    imgName=currDt.day.toString()+'-'+currDt.month.toString()+'-'+currDt.year.toString()+'-'+currDt.hour.toString()+'hr-'+currDt.minute.toString()+'min'+_x;
    print(imgName);
    firebaseStorageRef= FirebaseStorage.instance
        .ref()
        .child('images/$uemail')
        .child(imgName+'.jpg');


    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await (await taskSnapshot).ref.getDownloadURL();
    print(downloadUrl);

    CollectionReference record = Firestore.instance.collection("users").document(user.uid).collection("records").reference();
    await record.add(
        {'dr_level':_x,
    'photoUrl':downloadUrl,
      'date_and_time':currDt.day.toString()+'-'+currDt.month.toString()+'-'+currDt.year.toString()+'-'+currDt.hour.toString()+'hr-'+currDt.minute.toString()+'min',
    }
    );

    showInSnackBar("Image Uploaded to storage");

  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _pickImage=true;
                      pickImage();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(9.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _pickImage=false;
                      pickImage();

                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome To DR Test Zone",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: cColors.appbarColor,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    //margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _image == null
                            ? Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text("Please select your retinal image ")
                                    ],
                                  ),
                                ),
                              )
                            : Image.file(_image),
                        SizedBox(
                          height: 20,
                        ),
                        _outputs != null
                            ? Text(
                                _outputs[0]["label"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    background: Paint()
                                      ..color = Colors.greenAccent),
                              )
                            : Container(child: Text("")),
                        SizedBox(
                          height: 30.0,
                        ),
                        _image == null
                            ? Container()
                            : Row(
                              children: [
                                RaisedButton(
                                    onPressed: () async {
                                      //writeOnPdf();
                                      //await savePDF();
                                      //MyHomePage();
                                      String _x = _outputs[0]["label"] as String;
                                      level = int.parse(_x);
                                      debugPrint("Dtype clicked");
                                      debugPrint(_x);
                                      description="Your DR level :"+level.toString()+". "+descLevel[level];
                                      if (await Permission.storage.request().isGranted) {
                                        pdfimage = PdfImage.file(doc.document, bytes: File(_image.path).readAsBytesSync());
                                        writeOnPdf(heading,pdfimage,description);
                                        await savePDF().then((path) => {
                                          fullpath=path,
                                         print("Yes"),
                                          print(path),
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>
                                        PdfPreviewScreen(path)
                                        )
                                        ),
                                        }
                                        );


                                      }


                                    },
                                    padding: const EdgeInsets.all(0.0),
                                    color: Colors.greenAccent,
                                    child: Text("Generate Prescription"),
                                  ),


//sharing
                              SizedBox(width: 20),

                        RaisedButton(
                          child: Icon(Icons.share),
                          color: Colors.amber,
                          onPressed: () async {

                            String _x = _outputs[0]["label"] as String;

                            level = int.parse(_x);
                            debugPrint("Dtype clicked");
                            debugPrint(_x);

                            debugPrint("hello");

                            if(fullpath=="null"){
                              description="Your DR level :"+level.toString()+"."+descLevel[level];
                              if (await Permission.storage.request().isGranted) {

                                pdfimage = PdfImage.file(doc.document, bytes: File(_image.path).readAsBytesSync());
                                writeOnPdf(heading,pdfimage,description);
                                await savePDF().then((path) => {
                                  fullpath=path,
                                  print("Yes"),
                                  print(path),
                                Share.shareFiles(path.split(" "),text: "Example pdf"),
                                }
                                );


                              }
                            }


                          },
                        ),

                              ],
                        ),

                      ],
                    ),
                  ),
            //SizedBox(
            //height: MediaQuery.of(context).size.height * 0.01,
            //),
            RaisedButton(
              onPressed: () {
                _showChoiceDialog(context);
              },
              child: Icon(
                Icons.add_a_photo,
                size: 20,
                color: Colors.white,
              ),
              color: cColors.buttonColor,
            ),
          ],
        ),
      ),
    );
  }



  Future<String> savePDF() async {
    Directory documentDirectory = await DownloadsPathProvider.downloadsDirectory;;
    String documentPath = documentDirectory.path;
    String pdfpath= documentPath+"/"+cUser.displayName+"_"+imgName+"_"+level.toString()+".pdf";
    File file = new File(pdfpath);

    file.writeAsBytesSync(doc.save());
    print("save completed and the path is:"+ pdfpath);
    return pdfpath;
  }


  writeOnPdf(heading,PdfImage image,description) {
    doc.addPage(
        pdf.MultiPage(
        pageFormat: PdfPageFormat.a5,
        margin: pdf.EdgeInsets.all(32),
        build: (pdf.Context context)
        {
          return <pdf.Widget>
          [
            pdf.Center(
                child: pdf.Text(heading,
                    textAlign: pdf.TextAlign.center,
                    style: pdf.TextStyle(fontSize: 16.0))),
            pdf.SizedBox(height: 30.0),
            pdf.Image(image),
            pdf.Text(description,
                textAlign: pdf.TextAlign.left,
                style: pdf.TextStyle(fontSize: 15.0)
            ),
          ];
        }
        )
    );
  }
}
