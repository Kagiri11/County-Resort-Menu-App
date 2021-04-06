import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';

class Sliderr extends StatefulWidget {
  @override
  _SliderrState createState() => _SliderrState();
}

class _SliderrState extends State<Sliderr> {
  
  
  startTransaction({double amount, String phone}) async {
    dynamic transactionInitialisation;
    //Wrap it with a try-catch
    try {
      //Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: phone,
              partyB: "174379",
              callBackURL:
                  //Uri
                  Uri(
                      scheme: "https",
                      host: "my-app.herokuapp.com",
                      path: "/callback"),
              // scheme: "https",
              // host:
              // "us-central1-nigel-da5d1.cloudfunctions.net/paymentCallback"),
              accountReference: "payment",
              phoneNumber: phone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "demo",
              passKey:
                  "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
      //HashMap result = transactionInitialisation as HashMap <String, dynamic>;

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      //you can implement your exception handling here.
      //Network unreachability is a sure exception.
      print(e.getMessage());
    }
  }

  
  

  @override
  Widget build(BuildContext context) {
   String kConsumerKey ="6IDkqOaygzAjjTgYLIDNCPmqzV1GcBFh";
  String kConsumerSecret ="21TGSOeAyAvHjN9Q";
   MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);
    
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: RaisedButton(
          
          onPressed: (){
            startTransaction(
              amount: 1,
              phone: "254794362513"

            );
          },
          child: Text("Pay"),
          ),
      ),
    );
  }
  
}
