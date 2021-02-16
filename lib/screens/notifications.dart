import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/screens/services.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  Stream<QuerySnapshot> getUserAppointment(BuildContext context) async*{
    yield* FirebaseFirestore.instance
    .collection('appointments')
    .where('username', isEqualTo: 'jane')
    .orderBy('timeStamp', descending:true)
    .snapshots();

  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  
  


  Future getCurrentUser() async{
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail=user.email;
    print(uemail);
    print(uid);
  }
 

  var appointmentDtls;
  bool appointFlag=false;
   
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   AppointmentService()
  //   .getLatestAppointment('jane')
  //   .then((QuerySnapshot docs) {
  //     if(docs.docs.isNotEmpty){
  //       appointFlag=true;
  //       appointmentDtls=docs.docs[0].data;
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notify"),
      ),
      body: Center(
        child:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height:MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width*0.9,
                color: Colors.blue,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                  .collection("appointments")
                  .where('username', isEqualTo: 'jane')
                  .snapshots(),
                  builder: (context, snapshot){
                    return ListView.builder(
                      itemBuilder: (context, index){
                        DocumentSnapshot appointT=snapshot.data.documents[0];
                        final date= appointT['date'];

                        return Row(
                          children: [
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Center(
                              child:Text('${appointT['username']} ' + "has booked "+ date)
                              ),

                            ),
                          ],

                        );
                      },
                      );
                  },

                  ),
              ),
              Container(
                child:RaisedButton(
                  onPressed: getCurrentUser,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Text(""),
      ),
    );
  }
}