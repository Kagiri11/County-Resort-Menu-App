import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menuapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future getCurrentUser() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    print(uemail);
    print(uid);
  }
  

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    return Drawer(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                // color: Colors.pink,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 87,
                      width: 87,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      child: Center(
                        child: Container(
                          height: 85,
                          width: 85,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/user3.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "grac",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$uemail",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: ListTile(
                        leading: Icon(
                          Icons.business,
                          color: Colors.grey[400],
                        ),
                        title: Text("Home"),
                        onTap: () {
                          print("$uemail");
                        },
                      ),
                    ),
                    InkWell(
                      child: ListTile(
                        leading: Icon(
                          Icons.data_usage,
                          color: Colors.grey[400],
                        ),
                        title: Text("Reports"),
                        onTap: () {
                          print("object");
                        },
                      ),
                    ),
                     InkWell(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.dashboard,
                                      color: Colors.grey[400],
                                    ),
                                    title: Text("Dashboard"),
                                    onTap: () {
                                      if(uemail=='french@gmail.com'){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
                                      }
                                        
                                      
                                    },
                                  ),
                                ),
                              
                    InkWell(
                      child: ListTile(
                        leading: Icon(
                          Icons.menu,
                          color: Colors.grey[400],
                        ),
                        title: Text("Settings"),
                        onTap: () {
                          print("object");
                        },
                      ),
                    ),
                    InkWell(
                      child: ListTile(
                        leading: Icon(
                          Icons.power_settings_new,
                          color: Colors.grey[400],
                        ),
                        title: Text("Logout"),
                        onTap: () {
                          print("object");
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
  }

  
}
