import 'package:menuapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width,
            // color: Colors.pink,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: 50
                  ),
                  height: 87,
                  width: 87,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                  ),
                  child: Center(
                    child: Container(
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/user3.jpg"),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text("Grace Mkenya",style: TextStyle(
                  fontSize: 18
                ),),
                SizedBox(height: 10,),
                Text("mkenyaGrace@gmail.com",style: TextStyle(
                  color: Colors.grey[500]
                ),),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
//            color:Colors.green,
            child: Column(
              children: <Widget>[
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.business,color: Colors.grey[400],),
                    title: Text("Home"),
                    onTap: (){
                      print("object");
                    },
                  ),
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.data_usage,color: Colors.grey[400],),
                    title: Text("Reports"),
                    onTap: (){
                      print("object");
                    },
                  ),
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.dashboard,color: Colors.grey[400],),
                    title: Text("Dashboard"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
                      print("object");
                    },
                  ),
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.menu,color: Colors.grey[400],),
                    title: Text("Settings"),
                    onTap: (){
                      print("object");
                    },
                  ),
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.power_settings_new,color: Colors.grey[400],),
                    title: Text("Logout"),
                    onTap: (){
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