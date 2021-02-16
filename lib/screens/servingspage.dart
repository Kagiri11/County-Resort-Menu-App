import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:menuapp/models/servingsmodel.dart';



class ServingsPage extends StatefulWidget {
  final ValueSetter<ServingsModel> _valueSetter;
  ServingsPage(this._valueSetter);
  @override
  _ServingsPageState createState() => _ServingsPageState(this._valueSetter);
}

class _ServingsPageState extends State<ServingsPage> {
  final ValueSetter<ServingsModel> _valueSetter;
  _ServingsPageState(this._valueSetter);

  List<ServingsModel> servings=[
    ServingsModel("F-chicken","Closed fried chicken","assets/images/friedchicken.jpg",250,"14"),

  ];
  List<ServingsModel> drinks=[
    ServingsModel("Soup","Doctor's Soup","assets/images/soup.jpg",100,"2 hrs"),
  ];
  final snackBar=SnackBar(content: Text("item has been added",style: TextStyle(color: Colors.white),));
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
//        Container(
//          height: 300,width: MediaQuery.of(context).size.width,color: Colors.blue,
//          child: Container(
//
//            height: 200,
//            child: ListView.builder(
//                scrollDirection: Axis.horizontal,
//                itemCount: servings.length,
//                itemBuilder: (context, index){
//                  return Center(
//                    child: Card(
//                      child: InkWell(
//                        onTap: (){
//                          _valueSetter(servings[index]);
//                        },
//                        child: Container(
//                          height: 200,width: 200,color: Color.fromRGBO(54, 2, 89, 1),
//                          child: Column(
//                            children: <Widget>[
//                              Container(
//                                height: 130,width: 200,
//                                decoration: BoxDecoration(
//                                    color: Colors.green,
//                                image: DecorationImage(image: AssetImage("assets/images/chumba5.jpg"),fit: BoxFit.cover)
//                              ),
//                              ),
//                              SizedBox(height:20,child: Text(servings[index].name,style: TextStyle(color: Colors.white),)),
//                              SizedBox(height: 25,child: Text(servings[index].description,style: TextStyle(color: Colors.white),)),
//                              Text("${servings[index].price}",style: TextStyle(color: Colors.white),),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  );
//                }
//            ),
//          ),
//        ),
      Container(height: 260,width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10,top: 10),
            height: 30,width: MediaQuery.of(context).size.width,
            child: Text("Main Food",style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 15,color: Color.fromRGBO(54, 2, 89, 1),),),),
          Container(
          height: 200,width: MediaQuery.of(context).size.width,
          child: Container(

            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: servings.length,
                itemBuilder: (context, index){
                  return Center(
                    child: Card(
                      color: Colors.white,
                      child: InkWell(
                        onTap: (){
                          Scaffold.of(context).showSnackBar(snackBar);
                          _valueSetter(servings[index]);
                        },
                        child: Container(
                          height: 200,width: 200,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(54, 2, 89, 1),
                            borderRadius: BorderRadius.only(
                                bottomRight:Radius.circular(20),
                                bottomLeft: Radius.circular(20))
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 130,width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                image: DecorationImage(image: AssetImage(servings[index].image),fit: BoxFit.cover)
                              ),
                              ),
                              SizedBox(height:20,child: Text(servings[index].name,style: TextStyle(fontFamily:"Raleway",color: Colors.white),)),
                              SizedBox(height: 25,child: Text(servings[index].description,style: TextStyle(fontFamily: "Raleway",color: Colors.white),)),
                              Text("${servings[index].price}",style: TextStyle(fontFamily: "Raleway",color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
        ],
      ),
      ),
        SizedBox(height: 30,),
        Container(height: 260,width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10,top: 10),
                height: 30,width: MediaQuery.of(context).size.width,
                child: Text("Popular Drinks",style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 15,color: Color.fromRGBO(54, 2, 89, 1),),),),
              Container(
                height: 200,width: MediaQuery.of(context).size.width,
                child: Container(

                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: drinks.length,
                      itemBuilder: (context, index){
                        return Center(
                          child: Card(
                            color: Colors.white,
                            child: InkWell(
                              onTap: (){
                                Scaffold.of(context).showSnackBar(snackBar);
                                _valueSetter(drinks[index]);
                              },
                              child: Container(
                                height: 200,width: 200,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(54, 2, 89, 1),
                                    borderRadius: BorderRadius.only(
                                        bottomRight:Radius.circular(20),
                                        bottomLeft: Radius.circular(20))
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 130,width: 200,
                                      decoration: BoxDecoration(

                                          image: DecorationImage(image: AssetImage(drinks[index].image),fit: BoxFit.cover)
                                      ),
                                    ),
                                    SizedBox(height:20,child: Text(drinks[index].name,style: TextStyle(fontFamily: "Raleway",color: Colors.white),)),
                                    SizedBox(height: 25,child: Text(drinks[index].description,style: TextStyle(fontFamily: "Raleway",color: Colors.white),)),
                                    Text("${drinks[index].price}",style: TextStyle(fontFamily: "Raleway",color: Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}


