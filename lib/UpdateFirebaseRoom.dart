import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateFirebaseRoom {
  static Future<Null> exitRoom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String email = prefs.getString('email');
    await Firestore.instance
        .collection('room')
        .document(email)
        .updateData(<String, dynamic>{
      'user': FieldValue.increment(-1),
    });
  }

  static Future<Null> addEnc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String email = prefs.getString('email');
    await Firestore.instance
        .collection('room')
        .document(email)
        .updateData(<String, dynamic>{
      'user': FieldValue.increment(1),
    });
  }
  //   static Future<Null> addEnc() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   String email = prefs.getString('email');
  //   await Firestore.instance
  //       .collection('room')
  //       .document(email)
  //       .updateData(<String, dynamic>{
  //     email : false,
  //   });
  // }

  static Future<Null> addRoom({String mapel, String bab, String soal}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String email = prefs.getString('email');
    await Firestore.instance.collection('room').document(email).setData({
      "matpel": mapel,
      "bab": bab,
      "soal": soal,
      "email": email,
      "user": 1,
      "tipe": "One On One",
      "onChat": true,
      "onPlaying": false
    });
  }
}
