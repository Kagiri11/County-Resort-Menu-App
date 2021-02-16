

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';



class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
            width: MediaQuery.of(context).size.width*0.8,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Table"),
                  Text("Food Name"),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              color: Colors.orange,
              child: Container(
                height: 650,
                width: 500,
                color: Colors.white,
                child: StreamBuilder(
                    stream: Firestore.instance.collection("orders").snapshots(),
                    builder: (context, snapshot){
                      return ListView.builder(
                        shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context,index){
                            DocumentSnapshot cont=snapshot.data.documents[index];
                            return Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 440,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
//                                  Text("${cont['table']}"),
//                                  Text("${cont['name']}"),
                                    Container(height: 80,width: 90,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(54,2,89,1),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(40),
                                      )
                                    ),
                                      child: Center(child: Text('${cont['table']}',style: TextStyle(fontSize: 21,color: Colors.white),),),
                                    ),
                                      Container(height: 80,width: 250,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(54,2,89,1),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                            )
                                        ),
                                        child: Center(child: Text('${cont['name']}',style: TextStyle(fontSize: 21,color: Colors.white),),),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,)
                              ],
                            );
                          }
                      );
                    }),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,

            ),
          ],
        ),
      ),
    );
  }
}
