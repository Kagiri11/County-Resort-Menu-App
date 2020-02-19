import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/orders.dart';


class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String _email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.height*0.1,width: MediaQuery.of(context).size.width,color: Colors.red,),
            Form(
              key: _formKey,
              child: Container(height: MediaQuery.of(context).size.height*0.3,width: MediaQuery.of(context).size.width,color: Colors.blue,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Enter email"),
                    TextFormField(
                      validator: (input){
                        if(input.isEmpty){
                          return "Please enter email";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email"
                      ),
                      onSaved: (input)=>_email=input,
                    ),
                    Text("Enter Password"),
                    TextFormField(
                      validator:(input){
                        if(input.length<6){
                          return "Please enter a password that is more than six characters";
                        }
                      } ,
                      onSaved:(input) =>_password = input ,
                      decoration: InputDecoration(
                          labelText: "Email"
                      ),
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: signIn,
                      child: Text("Login"),
                    )
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        AuthResult user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }

}
