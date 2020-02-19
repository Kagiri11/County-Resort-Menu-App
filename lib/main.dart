import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menuapp/login.dart';
import 'package:menuapp/models/servingsmodel.dart';
import 'package:menuapp/orders.dart';
import 'package:menuapp/screens/checkout.dart';
import 'package:menuapp/screens/servingspage.dart';
import 'package:splashscreen/splashscreen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(54,2,89,1)
      ),
      home: OrdersPage(),
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
    return SplashScreen(
      seconds: 5,

      backgroundColor: Color.fromRGBO(54,2,89,1),
      title: Text("Welcome To County\nResort",style: TextStyle(fontSize: 25,fontFamily: "Raleway",color: Colors.white),textAlign: TextAlign.center,),
      loaderColor: Colors.white,
      loadingText: Text("Better Hotel Service",style: TextStyle(fontFamily: "Raleway",color: Colors.white),),
      navigateAfterSeconds: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ServingsModel> cart=[];
  int sum;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("County Resort Menu",style: TextStyle(fontFamily: "Quicksand Regular"),),
          actions: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin()));
              },
                child: Icon(Icons.adjust)
            ),
          ],
          bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.menu),),
            Tab(icon: Icon(Icons.account_balance_wallet),),
          ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ServingsPage((selectedFood){
              setState(() {
                cart.add(selectedFood);
                sum=0;
                cart.forEach((item){
                  sum+=item.price;
                });
              });
            }),
            CheckoutPage(cart,sum),

          ],
        ),
      ),
    );
  }
}

