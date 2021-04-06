import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:menuapp/screens/admin.dart';
import 'package:menuapp/screens/cart.dart';
import 'package:menuapp/screens/dashboard.dart';
import 'package:menuapp/screens/mpesa.dart';
import 'package:menuapp/screens/notifications.dart';
import 'package:menuapp/screens/sigu.dart';
import 'package:menuapp/screens/slider.dart';
import 'package:menuapp/screens/styles.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/login.dart';
import 'package:menuapp/signup.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
  String kConsumerKey ="6IDkqOaygzAjjTgYLIDNCPmqzV1GcBFh";
String kConsumerSecret ="21TGSOeAyAvHjN9Q";
MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey,

          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.grey[500]
      ),
      home:Splash(),
      // routes: {
      //   StylesPage.id:(context)=>StylesPage(),
      // },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return StylesPage();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SignUP();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}