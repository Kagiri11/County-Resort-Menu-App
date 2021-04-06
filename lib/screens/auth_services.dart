import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menuapp/screens/cart.dart';
import 'package:menuapp/screens/home.dart';
import 'package:menuapp/screens/sigu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/screens/styles.dart';


class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;


  // signUp
  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('/users').doc(signedInUser.uid).set({
          'name': name,
          'email': email,
          'profileImageUrl': '',
        });

        // Navigator.pushReplacementNamed(context, HomePage.id);
        // Navigator.pushReplacementNamed(context, StylesPage.id);
        print(name);
        print(email);
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }

//signOut
  static void logout(BuildContext context) {

    _auth.signOut();
    Navigator.pushReplacementNamed(context, SignUP.id);
  }

// login
  static void login(context, String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        print(user);
        // Navigator.pushReplacementNamed(context, StylesPage.id);
      }
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }

  // Reset Password
  static void sendPasswordResetEmail(context, String email) async {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }



  Future<void> fblogout() async {}
}

// Navigator.pushReplacementNamed( context, CartPage.id, arguments: {"name": name, "email": email}
