import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService{
  getLatestAppointment(String customerName){
    return FirebaseFirestore.instance
    .collection('appointments')
    .where('username' ,isEqualTo:customerName)
    .orderBy('timeStamp', descending: true)
    .snapshots();

  }
}