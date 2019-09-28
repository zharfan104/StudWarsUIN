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

  static Future<Null> addRoom(
      {String mapel,
      String nama_room,
      String bab,
      String soal,
      String email,
      String tipe}) async {
    await Firestore.instance
        .collection('room')
        .document(email + " " + nama_room)
        .setData({
      "matpel": mapel,
      "bab": bab,
      "soal": soal,
      "nama": nama_room,
      "email": email,
      "user": 1,
      "tipe": tipe,
      "onChat": true,
      "onPlaying": false
    });
  }
}
