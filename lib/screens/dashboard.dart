import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController _controller;
  var styletxt = TextEditingController();
  var durationtxt = TextEditingController();
  var pricetxt = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var storage = FirebaseStorage.instance;
  String stylename, duration, price;
  String extension, path;
  bool loadingpath = false;
  FileType picktype;
  bool hasValidMime = false;
  TextEditingController stylecontroller = new TextEditingController();
  TextEditingController durationcontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  File _image;
  final picker = ImagePicker();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    print(uemail);
    print(uid);
  }

  void upload() async {
    // final String filename;
    StorageTaskSnapshot snapshot =
        await storage.ref().child("Imagename").putFile(_image).onComplete;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("designs").add({
      "duration": durationcontroller.text,
      'style': stylecontroller.text,
      'price': pricecontroller.text,
      'picture': downloadUrl
    });
  }

  Future getImageFromGallery() async {
    // final pickedFile= await ImagePicker.pickImage(source: ImageSource.gallery);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  Future getImageFromCam() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from library"),
                    onTap: () {
                      getImageFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text("Choose from camera"),
                    onTap: () {
                      getImageFromCam();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Future getCurrentUser() async {
      final User user = auth.currentUser;
      final uid = user.uid;
      final uemail = user.email;
      print(uemail);
      print(user);
    }

    

    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;

    

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Dashboard Page"),
      ),
      body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.95,
                      // color: Colors.blue,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  print(uemail);
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("appointments")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<DocumentSnapshot> cont =
                                          snapshot.data.documents;
                                      var count = cont.length;
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        elevation: 3,
                                        child: Container(
                                          margin: EdgeInsets.all(15),
                                          height: 50,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.description,
                                                size: 35,
                                                color: Colors.grey[600],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 0,
                                                  ),
                                                  Text("$count"),
                                                  Text("Appointment",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("users")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    List<DocumentSnapshot> usercont =
                                        snapshot.data.documents;
                                    var ucount = usercont.length;
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 3,
                                      child: Container(
                                        margin: EdgeInsets.all(15),
                                        height: 50,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.account_circle,
                                              size: 35,
                                              color: Colors.grey[600],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 0,
                                                ),
                                                Text("$ucount"),
                                                Text(
                                                  "Customers",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("designs")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    List<DocumentSnapshot> designcont =
                                        snapshot.data.documents;
                                    var dcount = designcont.length;
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 3,
                                      child: Container(
                                        margin: EdgeInsets.all(15),
                                        height: 50,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.style,
                                              size: 35,
                                              color: Colors.grey[600],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 0,
                                                ),
                                                Text("$dcount"),
                                                Text(
                                                  "Designs",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Card(
                  //     elevation: 3,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(5)
                  //     ),
                  //     child: Container(
                  //       margin: EdgeInsets.only(
                  //           top: 10
                  //       ),
                  //       height: MediaQuery.of(context).size.height*0.3,
                  //       width: MediaQuery.of(context).size.width*0.9,
                  //       decoration: BoxDecoration(

                  //         borderRadius: BorderRadius.circular(5)
                  //       ),
                  //       child: Column(
                  //         children: <Widget>[
                  //           Container(
                  //             height: 40,
                  //             width: MediaQuery.of(context).size.width*0.9,
                  //             // color: Colors.blue,
                  //             child: Row(
                  //               children: <Widget>[
                  //                 SizedBox(width: 20,),
                  //                 Text("Recent Activities"),
                  //                 Flexible(child: Container()),
                  //                 Container(
                  //                   height: 80,
                  //                   width: 80,
                  //                   child: InkWell(
                  //                     splashColor: Colors.blue,
                  //                     onTap:(){
                  //                       _popupDialog(context);
                  //                     },
                  //                       child: Icon(Icons.add)),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //           Divider(
                  //             thickness: 1,
                  //           ),
                  //           Container(
                  //             height:40 ,
                  //             width: MediaQuery.of(context).size.width*0.9,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //               children: <Widget>[
                  //                 Text("Posted a new Design"),
                  //                 SizedBox(width: 40,),
                  //                 Text("14th June 20",style: TextStyle(color: Colors.grey),)

                  //               ],
                  //             ),

                  //           ),
                  //           Container(
                  //             height:40 ,
                  //             width: MediaQuery.of(context).size.width*0.9,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //               children: <Widget>[
                  //                 Text("Posted a new Design"),
                  //                 SizedBox(width: 40,),
                  //                 Text("14th June 20",style: TextStyle(color: Colors.grey),)

                  //               ],
                  //             ),

                  //           ),
                  //           Container(
                  //             height:40 ,
                  //             width: MediaQuery.of(context).size.width*0.9,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //               children: <Widget>[
                  //                 Text("Posted a new Design"),
                  //                 SizedBox(width: 40,),
                  //                 Text("14th June 20",style: TextStyle(color: Colors.grey),)

                  //               ],
                  //             ),

                  //           ),
                  //           Divider(thickness: 2,),
                  //           Flexible(
                  //             child: Container(

                  //               width: MediaQuery.of(context).size.width*0.9,
                  //               child: Center(
                  //                 child: Text("See More",style: TextStyle(color: Colors.blue),),
                  //               )

                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.9,
                              // color: Colors.blue,
                              child: Container(
                                height: 80,
                                width: 80,
                                child: InkWell(
                                    splashColor: Colors.blue,
                                    onTap: () {
                                      _popupDialog(context);
                                    },
                                    child: Icon(Icons.add)),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 185,
                                          width: 100,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                controller: stylecontroller,
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return "Please enter style";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    labelText: "style"),
                                                onSaved: (input) => stylename = input,
                                              ),
                                              TextFormField(
                                                controller: durationcontroller,
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return "Please enter Duration";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    labelText: "Duration"),
                                                onSaved: (input) => duration = input,
                                              ),
                                              TextFormField(
                                                controller: pricecontroller,
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return "Please enter price";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    labelText: "Price"),
                                                onSaved: (input) => price = input,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            width: 100,
                                            child: Center(
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                child: _image == null
                                                    ? Text("No image is selected")
                                                    : Image.file(_image),
                                              ),
                                            )),
                                        RaisedButton(
                                          onPressed: () {
                                            upload();
                                          },
                                          child: Text("Post"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.blue,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("appointments")
                            .snapshots(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot apnt = snapshot.data.documents[index];
                              return Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Center(
                                        child: Text('${apnt['email']} ' +
                                            "has booked " +'${apnt['style']}')),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
    );
  }

  

  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Card(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 80,
                      child: _image == null
                          ? Text("No image is selected")
                          : Image.file(_image),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: FloatingActionButton(
                          onPressed: () {
                            showPicker(context);
                            setState(() {
                              _image = _image;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
