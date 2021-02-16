
import 'package:menuapp/screens/admindrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Classic Salon Admin"),
        actions: <Widget>[
          Icon(Icons.more_vert),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: AdminDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
            crossAxisCount: 2,
          children:List.generate(4, (index){
            return Card(
              elevation: 5,
              child: Container(
                color: Colors.grey,
                height: 200,
                width: 200,
              ),
            );
          })
        ),
      ),
    );
  }
}