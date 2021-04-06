import 'package:menuapp/screens/auth_services.dart';
import 'package:menuapp/screens/home.dart';
import 'package:menuapp/screens/log_screen.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SignUP extends StatefulWidget {
  static final String id = "logi";
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool _obSecureText = false;
  String _name, _email, _password;
  bool isSignIn = false;
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();





  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  _toggle() {
    setState(() {
      _obSecureText = !_obSecureText;
    });
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.signUpUser(context, _name, _email, _password);
    }
  }

  void _onLoading() {
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
              '    Signing-In...',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
        leading: FlatButton(
          textColor: Colors.white,
          onPressed: () {},
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (name) =>
                            name.trim().isEmpty ? 'Enter valid name' : null,
                        onSaved: (name) => _name = name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (input){
                          if(input.isEmpty){
                            return "Please enter email";
                          }
                        },
                        onSaved: (email) => _email = email,
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter phone number',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        validator: (password) => password.length != 13
                            ? "Enter valid phone number"
                            : null,
                      ),
                    ),
                    */
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.black,
                            icon: _obSecureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: _toggle,
                          ),
                          labelText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                          ),
                        ),
                        obscureText: _obSecureText,
                        validator: (password) => password.length < 5
                            ? 'Password mut be atleast 5 characters'
                            : null,
                        onSaved: (password) => _password = password,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      width: 340.0,
                      height: 45.0,
                      child: FlatButton(
                          onPressed: () {
                            _submit();
                            _onLoading();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                          color: Colors.black,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'ProductSans-Bold',
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*   
   validator: (value){
     if(value.isEmpty) {
       setState((){
          errors.add('Please enter your email');
       });
     }
     return null; 
   }
 */
