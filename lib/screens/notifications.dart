import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:menuapp/screens/mpesa.dart';

import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';


import 'package:menuapp/screens/styles.dart';

import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Stream<QuerySnapshot> getUserAppointment(BuildContext context) async* {
    yield* FirebaseFirestore.instance
        .collection('appointments')
        .where('username', isEqualTo: 'jane')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    print(uemail);
    print(uid);
  }

  var appointmentDtls;
  bool appointFlag = false;

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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.blue,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("appointments")
                      .where('username', isEqualTo: 'jane')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot cont =
                              snapshot.data.documents[index];
                          var bookedDate = cont['datetime'];
                          var goodbooked = DateTime.fromMicrosecondsSinceEpoch(
                              bookedDate.microsecondsSinceEpoch);
                          var currentDate = DateTime.now();
                          int differenceInTime =
                              goodbooked.difference(currentDate).inSeconds;

                          FlutterLocalNotificationsPlugin fltrNotification;
                          @override
                          void initState() {
                            // TODO: implement initState
                            super.initState();
                            var androidInitialize =
                                new AndroidInitializationSettings('logo.png');
                            var iOSInitialize = new IOSInitializationSettings();
                            var initializationStngs =
                                new InitializationSettings(
                                    android: androidInitialize,
                                    iOS: iOSInitialize);
                            fltrNotification =
                                new FlutterLocalNotificationsPlugin();
                            fltrNotification.initialize(initializationStngs,
                                onSelectNotification: notificationSelected);
                          }

                          CountdownTimerController controller;

                          int endTime =
                              DateTime.now().millisecondsSinceEpoch + 2000 * 3;

                          Future _showNotification() async {
                            var androidDetails = new AndroidNotificationDetails(
                                "Channel Id", "Kagiri Prog", "This is me",
                                importance: Importance.max);
                            var iOSDetails = new IOSNotificationDetails();
                            var generalNotificationDetails =
                                new NotificationDetails(
                                    android: androidDetails, iOS: iOSDetails);
                            var scheduledTime =
                                new DateTime.now().add(Duration(seconds: 30));

                            // await fltrNotification.show(0, "Task", "body", generalNotificationDetails, payload: "Task");
                            fltrNotification.schedule(0, "Task", "body",
                                scheduledTime, generalNotificationDetails);
                          }

                          Future _zonedScheduleNotification() async {
                            var androidDetails = new AndroidNotificationDetails(
                                "Channel Id", "Kagiri Prog", "This is me",
                                importance: Importance.max);
                            var iOSDetails = new IOSNotificationDetails();
                            var generalNotificationDetails =
                                new NotificationDetails(
                                    android: androidDetails, iOS: iOSDetails);
                            var scheduledTime =
                                DateTime.now().add(Duration(seconds: 5));
                            await fltrNotification.zonedSchedule(
                                0,
                                "title",
                                "body",
                                scheduledTime,
                                generalNotificationDetails,
                                uiLocalNotificationDateInterpretation:
                                    UILocalNotificationDateInterpretation
                                        .absoluteTime,
                                androidAllowWhileIdle: true);
                          }

                          void printname() {
                            print("thend");
                          }

                          Timer(Duration(seconds: 5), () {
                            print(differenceInTime);
                          });

                          return Column(
                            children: <Widget>[
                              Container(
                                // height: 100,
                                width: 440,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text("$currentDate"),
                                    Text("$differenceInTime"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: RaisedButton(
                                  onPressed: _showNotification,
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Notification Clicked $payload"),
            ));
  }
}

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  void _onDeleting() {
    _scaffoldkey.currentState.showSnackBar(
      new SnackBar(
        duration: new Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
            new Text(
              '   Deleting...',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlutterLocalNotificationsPlugin fltrNotification;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new AndroidInitializationSettings("logo");
    var iOSInitialize = new IOSInitializationSettings();
    var initializationStngs = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationStngs,
        onSelectNotification: notificationSelected);
  }

  Future _zonedScheduleNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel Id", "Kagiri Prog", "This is me",
        importance: Importance.max);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);
    var scheduledTime = DateTime.now().add(Duration(seconds: 5));
    await fltrNotification.zonedSchedule(
        0, "title", "body", scheduledTime, generalNotificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel Id", "Kagiri Prog", "This is me",
        importance: Importance.max);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);
    var scheduledTime = new DateTime.now().add(Duration(seconds: 3));

    // await fltrNotification.show(0, "Task", "body", generalNotificationDetails, payload: "Task");
    fltrNotification.schedule(
        0, "Task", "body", scheduledTime, generalNotificationDetails);
  }

  void onPressed() {
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("appointments")
        .doc(user.email)
        .get()
        .then((value) {
      print(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    final uname = FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: uemail)
        .snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("appointments")
              .where('email', isEqualTo: uemail)
              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot cont = snapshot.data.documents[index];
                  var bookedDate = cont['datetime'];
                  int docCount = snapshot.data.documents.length;
                  var goodbooked = DateTime.fromMicrosecondsSinceEpoch(
                      bookedDate.microsecondsSinceEpoch);
                  var currentDate = DateTime.now();
                  var differenceInTime =
                      goodbooked.difference(currentDate).inSeconds;
                  var duration = goodbooked.difference(currentDate).inDays;

                  Future _showNotification() async {
                    var androidDetails = new AndroidNotificationDetails(
                        "Channel Id", "Kagiri Prog", "This is me",
                        importance: Importance.max);
                    var iOSDetails = new IOSNotificationDetails();
                    var generalNotificationDetails = new NotificationDetails(
                        android: androidDetails, iOS: iOSDetails);
                    var scheduledTime =
                        new DateTime.now().add(Duration(seconds: 3));

                    // await fltrNotification.show(0, "Task", "body", generalNotificationDetails, payload: "Task");
                    fltrNotification.schedule(
                        0,
                        "Classic Touch Salon",
                        "It is time to get your ${cont['style']} done",
                        scheduledTime,
                        generalNotificationDetails);
                  }

                  if (differenceInTime <= 0) {
                    Timer(Duration(seconds: differenceInTime), () {
                      _showNotification();
                      print("please work");
                    });
                  }
                  if (docCount > 0) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Center(
                                          child: Text(
                                              "You have an appointment $duration days from now"))),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RaisedButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("appointments")
                                              .where('email', isEqualTo: uemail)
                                              .get()
                                              .then((value) {
                                            value.docs.forEach((element) {
                                              FirebaseFirestore.instance
                                                  .collection("appointments")
                                                  .doc(element.id)
                                                  .delete()
                                                  .then((value) {
                                                print("Success!");
                                              });
                                            });
                                          });

                                          setState(() {
                                            _onDeleting();
                                            return Center(
                                              child: Text("data"),
                                            );
                                          });

                                          print("object");
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      RaisedButton(
                                        color: Colors.green,
                                        onPressed: () {
                                          _popupDialog(context);
                                          print("pay");
                                        },
                                        child: Text("Pay"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                              child: Text("data"),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Center(
                                    child: Text("data 2"),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Center(
                                    child: Text("data 3"),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                });
          }),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Notification Clicked $payload"),
            ));
  }
  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Colors.white,
                ),
                
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  children: <Widget>[
                    
                       RaisedButton(
                        color: Colors.blue,
                        onPressed: (){
                          _payment();
                        },
                        child: Text("Square Payment"),
                        ),
                    
                    
                       Center(
                        child: RaisedButton(
                          color: Colors.green,
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                          },
                          child: Text("Mpesa Payment"),
                          ),
                      ),
                    
                  ],
                ),
              ),
            
          );
        });
  }

  _payment() async {
    await InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-oD7AGrHOLBQeMnZk6e1Q2A');
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: (CardDetails result) {
          try {
            result.nonce;
            print('Sucess');
            InAppPayments.completeCardEntry(
                onCardEntryComplete: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StylesPage())));
          } catch (ex) {
            InAppPayments.showCardNonceProcessingError(ex.toString());
          }
        },
        onCardEntryCancel: () {});
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  //Future<dynamic>
  startTransaction({double amount, String phone}) async {
    dynamic transactionInitialisation;
    //Wrap it with a try-catch
    try {
      //Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: phone,
              partyB: "174379",
              callBackURL:
                  //Uri
                  Uri(
                      scheme: "https",
                      host: "my-app.herokuapp.com",
                      path: "/callback"),
              // scheme: "https",
              // host:
              // "us-central1-nigel-da5d1.cloudfunctions.net/paymentCallback"),
              accountReference: "payment",
              phoneNumber: phone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "demo",
              passKey:
                  "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
      //HashMap result = transactionInitialisation as HashMap <String, dynamic>;

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      //you can implement your exception handling here.
      //Network unreachability is a sure exception.
      print(e.getMessage());
    }
  }

  @override

  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mpesa Demo'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
                      .collection("appointments")
                      .where('email', isEqualTo: uemail)
                      .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
                DocumentSnapshot cont = snapshot.data.documents[index];
                var price=cont['amount'];
                var newprice=double.parse(price);
                          return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You are requested to pay $newprice',
                    ),
                    
                    RaisedButton(
                      child: Text("Pay"),
                      onPressed:(){
                        startTransaction(amount: newprice, phone: "254794362513");
                      }
                      )
                  ],
                ),
              );
              }
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => startTransaction(amount: 2, phone: "254794362513"),
          tooltip: 'Increment',
          child: Text('Pay'),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

