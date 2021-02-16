

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/login.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              //create validator
              validator: (input){
                if(input.isEmpty){
                  return "Please enter valid email";
                }
              },
              //decoration
              decoration: InputDecoration(
                labelText: "Email"
              ),
              //method after
              onSaved:(input)=>_email=input,
            ),
            TextFormField(
              //create a validator
              validator: (input){
                if(input.length<6){
                  return "Password must be longer than six ";
                }
              },
              //decoration
              decoration: InputDecoration(
                labelText: "password"
              ),
              //method after
              onSaved: (input)=>_password=input,
            ),
            RaisedButton(
              child: Text("Register"),
              onPressed: register,
            )
          ],
        ),
      ),
    );
  }
void register() async{
   final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin()));
      } catch (e) {
        print(e.message);
      }
    }
}

}