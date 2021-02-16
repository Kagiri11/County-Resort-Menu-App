import 'package:menuapp/screens/admindrawer.dart';
import 'package:menuapp/screens/cart.dart';
import 'package:menuapp/screens/home.dart';
import 'package:flutter/material.dart';

class Design {
  String style;
  String image;
  String price;
  String time;

  Design(String style, String image, String price, String time) {
    this.style = style;
    this.image = image;
    this.price = price;
    this.time = time;
  }
}

class StylesPage extends StatefulWidget {
  static final String id= "style";
//  final ValueSetter<Design> _valueSetter;
  @override
  _StylesPageState createState() => _StylesPageState();
}

class _StylesPageState extends State<StylesPage> {
  List<Design> _cart=[];
  static List<Design> designs = [
    Design("Monalisa", "assets/images/monalisa.jpg", "Kshs 1200", "40 minutes"),
    Design("Braids", "assets/images/monalisa.jpg", "Kshs 1200", "40 minutes")
  ];
  static List<Design> manicure = [
    Design("Monalisa", "Monalisa image", "Kshs 1200", "40 minutes"),
    Design("Braids", "Braids image", "Kshs 1200", "40 minutes")
  ];
  static List<Design> pedicure = [
    Design("Monalisa", "Monalisa image", "Kshs 1200", "40 minutes"),
    Design("Braids", "Braids image", "Kshs 1200", "40 minutes")
  ];
  static List<Design> massage = [
    Design("Monalisa", "Monalisa image", "Kshs 1200", "40 minutes"),
    Design("Braids", "Braids image", "Kshs 1200", "40 minutes")
  ];


//  final ValueSetter<Design> _valueSetter;
//  _StylesPageState(valueSetter, this._valueSetter);


  int _selectedIndex = 0;

//  This controls the bottom navigation drawer selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    Map<String, String> args=ModalRoute.of(context).settings.arguments;
    List<Widget> _navOptions = <Widget>[
      HomePage((selectedStyle){
        setState(() {
          if(_cart.length>0){
            _cart.removeAt(0);
            _cart.add(selectedStyle);
          }
          else{
            _cart.add(selectedStyle);
          }
        });
      }),
      CartPage(_cart),
      Text("Notifications")
    ];
    return Scaffold(
      drawer: AdminDrawer(),
      body: _navOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text("Appointment"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text("Notifications"),
          ),
        ],
      ),
    );
  }
}
