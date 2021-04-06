import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/screens/styles.dart';
// import 'package:classicsalon/screens/cart.dart';



class HomePage extends StatefulWidget {
  final ValueSetter<Design>_valueSetter;
  HomePage(this._valueSetter);

  @override
  _HomePageState createState() => _HomePageState(this._valueSetter);
}

class _HomePageState extends State<HomePage> {
  final ValueSetter<Design> _valueSetter;
  _HomePageState(this._valueSetter);

  static List<Design> designs = [
    Design("Monalisa", "assets/images/monalisa.jpg", "1", "40 minutes"),
    Design("Braids", "assets/images/braids.jpg", "1200", "40 minutes"),
    Design("Rvssian", "assets/images/style.jpg", "1200", "40 minutes"),
    Design("Abuja", "assets/images/style2.jpg", "1200", "40 minutes")
  ];
  static List<Design> manicure = [
    Design("Shut Afro", "assets/images/des2.jpeg", "Kshs 1200", "40 minutes"),
    Design("Coco Tails", "assets/images/des3.jpg", "Kshs 2500", "40 minutes"),
    Design("Spanish", "assets/images/des1.jpg", "Kshs 2000", "40 minutes"),
  ];
  static List<Design> pedicure = [
    Design("Monalisa", "Monalisa image", "Kshs 1200", "40 minutes"),
    Design("Braids", "Braids image", "Kshs 1200", "40 minutes")
  ];
  static List<Design> massage = [
    Design("Monalisa", "Monalisa image", "Kshs 1200", "40 minutes"),
    Design("Braids", "Braids image", "Kshs 1200", "40 minutes")
  ];
  List<Design> _cart;
  final snackbar=SnackBar(content: Text("Item added"));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Classic Styles"),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.style),
              text: "Hairdressing",
            ),
            Tab(
              icon: Icon(Icons.map),
              text: "Manicure",
            ),
            Tab(
              icon: Icon(Icons.map),
              text: "Pedicure",
            ),
            Tab(
              icon: Icon(Icons.spa),
              text: "Massage",
            ),
          ]),
        ),
        body: TabBarView(children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10,),
                  Text("Featured Designs")
                  
                ],
              ),
              Container(
                height: 210,
                width: 600,
                // color: Colors.pink,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  itemCount: designs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            Scaffold.of(context).showSnackBar(snackbar);
                            _valueSetter(designs[index]);
                          });
                        },

                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                         // color: Colors.blue,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(designs[index].image),
                                      fit: BoxFit.cover
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    
                                  ),
                                ),
                                Container(
                                  height: 42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  width: 200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      color: Colors.grey[300],
                                    ),
                                    width: 200,
                                    child: Center(
                                      child: Text(designs[index].style),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
                child: SizedBox(
                  height: 20,
                  child: Text("Latest Designs"),
                ),
              ),
              Container(
                height: 210,
                width: 600,
                // color: Colors.pink,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("designs").snapshots(),
                  builder: (context, snapshot){
                    return ListView.builder(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    itemCount: snapshot.data.documents.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DocumentSnapshot cont=snapshot.data.documents[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              Scaffold.of(context).showSnackBar(snackbar);
                              _valueSetter(cont[index]);
                            });
                          },

                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 150,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(cont['picture']),
                                          fit: BoxFit.cover
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),

                                    ),
                                  ),
                                  Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    width: 200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        color: Colors.grey[300],
                                      ),
                                      width: 200,
                                      child: Center(
                                        child: Text('${cont['style']}'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
  }
                ),
              ),
//               Container(
//                 height: 200,
//                 width: 600,
//                 color: Colors.pink,
//                 child: ListView.builder(
//                   itemCount: designs.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: (){
//                         setState(() {
//                           if (_cart.contains(designs[index])){
//                             _cart.remove(designs[index]);
//                           }
//                           else
//                             Scaffold.of(context).showSnackBar(snackbar);
//                             _cart.add(designs[index]);
//                         });
//                       },
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(15)),
//                         ),
//                         child: Container(
//                           height: 200,
//                           width: 200,
//                           decoration: BoxDecoration(
// //                          color: Colors.blue,
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                           child: Column(
//                             children: <Widget>[
//                               Container(
//                                 height: 150,
//                                 width: 200,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(15),
//                                     topRight: Radius.circular(15),
//                                   ),
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Flexible(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15),
//                                     ),
//                                   ),
//                                   width: 200,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(15),
//                                         bottomRight: Radius.circular(15),
//                                       ),
//                                       color: Colors.grey[300],
//                                     ),
//                                     width: 200,
//                                     child: Center(
//                                       child: Text(designs[index].style),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: 600,
                color: Colors.pink,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  itemCount: manicure.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            Scaffold.of(context).showSnackBar(snackbar);
                            _valueSetter(manicure[index]);
                          });
                          },
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
//                          color: Colors.blue,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(manicure[index].image)),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),

                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    width: 200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        color: Colors.grey[300],
                                      ),
                                      width: 200,
                                      child: Center(
                                        child: Text(manicure[index].style),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: 600,
                color: Colors.pink,
                child: ListView.builder(
                  itemCount: manicure.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
//                          color: Colors.blue,
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                width: 200,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    color: Colors.grey[300],
                                  ),
                                  width: 200,
                                  child: Center(
                                    child: Text(manicure[index].style),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Text("This is for pedicure styles"),
          Text("This is for face job styles"),
        ]),
      ),
    );
  }

}
