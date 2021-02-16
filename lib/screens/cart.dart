import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/screens/styles.dart';

class CartPage extends StatefulWidget {

  final List _cart;

  CartPage(this._cart);

  @override
  _CartPageState createState() => _CartPageState(this._cart);
}

class _CartPageState extends State<CartPage> {

  List _cart;

  _CartPageState(this._cart);
  DateTime selectedDate = new DateTime.now();
  TimeOfDay selectedTime = new TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay pickedT= await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget child){
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );
    }

    );
    if (pickedT != null && pickedT != selectedTime)
      setState(() {
        selectedTime=pickedT;
      });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
    if (pickedDate != null && pickedDate != selectedDate)
      print("Date Selected is:${selectedDate.toString()}");
    setState(() {
      selectedDate = pickedDate;
    });

  }






  @override
  Widget build(BuildContext context) {
    if (_cart.length < 1) {
      // Center(
      //   child: Container(
      //       height: MediaQuery.of(context).size.height * 0.2,
      //       width: MediaQuery.of(context).size.width * 0.7,
      //       color: Colors.orange,
      //       child: Text("you have not chosen any designs")),
      // )
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        child: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              height: MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width*0.65,
              child:Center(child: Text("No Design selected"))
            ),
          ),
        ),
      );
    } else {
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, snapshot) {

              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[500],
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.7,
//            color: Colors.pink,
                    child: Center(
                      child: ListView.builder(
                        itemCount: _cart.length,
                        itemBuilder: (context, index) {
                          var item = _cart[index];
                          DocumentSnapshot cont=snapshot.data.documents[index];
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                    ),
                                    child: Image(
                                        image: AssetImage(_cart[index].image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Selected style: ${item.style}"),
                                          Text("Price:  ${item.price}"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  _selectTime(context);
                                                },
                                                  child: Text("${selectedTime.format(context)}")),
                                              InkWell(
                                                onTap: (){
                                                  _selectDate(context);
                                                },
                                                  child: Text("${selectedDate.toLocal()}".split(' ')[0]))
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Center(
                                          child: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                _cart.removeAt(0);
                                              });
                                            },
                                            child: Text("Clear"),
                                          ),
                                        ),
                                        Center(
                                          child: RaisedButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("appointments")
                                                  .add({
                                                'username': cont['name'],
                                                'style': "${item.style}",
                                                'date':"${selectedDate.toLocal()}".split(' ')[0],
                                                'time':selectedTime.format(context)
                                              });

                                              print("${selectedDate.toLocal()}".split(' ')[0]);
                                              print(selectedTime.format(context));
                                              print("${item.style}");
                                              print(cont['name']);


                                            },
                                            child: Text("Book Now"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          );

    }
  }
}
