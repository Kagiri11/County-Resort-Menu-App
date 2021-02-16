import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:numberpicker/numberpicker.dart';




class CheckoutPage extends StatefulWidget {
  final cart;
  var sum;
  CheckoutPage(this.cart,this.sum);
  @override
  _CheckoutPageState createState() => _CheckoutPageState(this.cart,this.sum);
}

class _CheckoutPageState extends State<CheckoutPage> {
  final cart;
  var sum;
  addOrder(){

  }
  _CheckoutPageState(this.cart,this.sum);
  int _currentValue =0;
  @override

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 70,
                          width: 80,

                          child: Center(
                            child: NumberPicker.integer(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              highlightSelectedValue: false,
                                zeroPad: false,
                              initialValue: _currentValue,
                              minValue: 0,
                              maxValue: 17,
                              onChanged: (newValue)=>setState(() => _currentValue = newValue),
                            ),
                          ),
                        ),
                        Container(height: 80,width: 80,
                          child: Center(child: Text("swipe",style: TextStyle(color: Color.fromRGBO(54, 2, 89, 1),),)),)
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 70,
                      width: 70,

                      decoration: BoxDecoration(
                        color: Color.fromRGBO(54, 2, 89, 1),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Container(
                          height: 40,width: 40,
                          child: Center(
                            child: Text("$_currentValue",
                              style: TextStyle(color: Colors.white,fontSize: 22,fontFamily: "Raleway"),),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 70,
                      width: MediaQuery.of(context).size.width*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Center(child: Text("Till No:\n 097581",style: TextStyle(color: Color.fromRGBO(54, 2, 89, 1),fontFamily: "Raleway",fontSize: 21),),),
                    )
                  ],
                ),
              ),
              SizedBox(height: 2,),
              Container(
                height: MediaQuery.of(context).size.height*0.65,
                width: MediaQuery.of(context).size.width,

                child: ListView.builder(
                    itemCount: cart.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width*0.9,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 80,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width*0.7,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(54, 2, 89, 1),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomLeft: Radius.circular(40))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(cart[index].name,style: TextStyle(color: Colors.white,fontFamily:"Raleway",fontSize: 21),),
                                        Text("Ksh ${cart[index].price}",style: TextStyle(color: Colors.white,fontFamily: "Raleway",fontSize: 21),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width*0.1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          onTap:(){
                                            print("sofia");
                                            setState(() {
                                              FirebaseFirestore.instance.runTransaction((transaction)async{
                                                await transaction.set(FirebaseFirestore.instance.collection("orders").doc(),{
                                                  'name': cart[index].name,
                                                  'table':_currentValue
                                                });
                                              });
                                            });
                                          },
                                          child: Container(
                                            height: 37.5,
                                            width: MediaQuery.of(context).size.width*0.15,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(54, 2, 89, 1),
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(50),
                                                    bottomRight: Radius.circular(50))
                                            ),
                                            child: Icon(Icons.check,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        InkWell(
                                          onTap:(){
                                            print("remove");
                                            cart.removeAt(index);
                                            setState(() {
                                              sum=0;
                                              cart.forEach((item){
                                                sum=sum+item.price;
                                              });
                                            });

                                          },
                                          child: Container(
                                            height: 37.5,
                                            width: MediaQuery.of(context).size.width*0.15,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(54, 2, 89, 1),
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(50),
                                                    bottomRight: Radius.circular(50))
                                            ),
                                            child: Icon(Icons.cancel,color: Colors.white,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,width: MediaQuery.of(context).size.width*0.6,child: Divider(thickness: 1,),)
                          ],
                        ),
                      );
                    }

                ),
              ),

            ],
          ),

        ),
        Container(
          child: SpeedDial(
            overlayColor: Colors.grey,
            overlayOpacity: 0.3,
            marginRight: 17,
            marginBottom: 22,
            elevation: 20,
            backgroundColor: Color.fromRGBO(54, 2, 89, 1),
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                backgroundColor: Colors.purple,
                child: Container(
                  height: 30,
                  width: 400,

                  child: Center(child: Text("$sum",style: TextStyle(fontSize: 14,fontFamily: "Raleway",color: Colors.white),)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(54, 2, 89, 1),

                  ),
                ),
              ),
              SpeedDialChild(
                backgroundColor: Color.fromRGBO(54, 2, 89, 1),
                child: Container(
                  height: 30,
                  width: 400,

                  child: Center(child: Text("${cart.length}",style: TextStyle(fontSize: 18,fontFamily: "Raleway",color: Colors.white),)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(54, 2, 89, 1),

                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );

  }
}

//return ListTile(
//                  leading: Text("Ksh ${cart[index].price}"),
//                  title: Text(cart[index].name),
//                  trailing: Text(cart[index].description),
//                  onTap: (){
//                    print("obj");
//                    setState(() {
//                      table=0;
//                      Firestore.instance.runTransaction((transaction)async{
//                        await transaction.set(Firestore.instance.collection("orders").document(),{
//                          'name': cart[index].name,
//                           'table':table,
//                        });
//                      });
//                    });
//                    },
//                );
