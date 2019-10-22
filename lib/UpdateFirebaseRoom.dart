import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_login/gamestate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

class UpdateFirebaseRoom {
  static Future<Null> imPlay({tipe, email, roomEmail, namaRoom}) async {
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData({'soal.${email.replaceAll(".", "")}': 0});
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData({'poin.${email.replaceAll(".", "")}': 0});
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData({'jawaban_soal.${email.replaceAll(".", "")}.0': true});
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData({'soal.game': 0});
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData(
            {'isi_room.${email.replaceAll(".", "")}': GSTATE.main.index});
  }

  static Future<Null> donePlay({email, @required isWin}) async {
    if (isWin) {
      await Firestore.instance
          .collection('user')
          .document('$email')
          .updateData({'menang': FieldValue.increment(1)});
    } else {
      await Firestore.instance
          .collection('user')
          .document('$email')
          .updateData({'kalah': FieldValue.increment(1)});
    }
  }

  static Future<Null> exitRoom({tipe, email, roomEmail, namaRoom}) async {
    await Firestore.instance
        .collection('user')
        .document(email)
        .updateData({'playwith': "null"});
    await Firestore.instance
        .collection('room')
        .document('$roomEmail $namaRoom')
        .updateData({'user': FieldValue.increment(-1)});
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData(
            {'isi_room.${email.replaceAll(".", "")}': GSTATE.keluar.index});
  }

  static Future<Null> imNotReady({tipe, email, roomEmail, namaRoom}) async {
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData(
            {'isi_room.${email.replaceAll(".", "")}': GSTATE.masuk.index});
  }

  static Future<Null> imReady({tipe, email, roomEmail, namaRoom}) async {
    await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData(
            {'isi_room.${email.replaceAll(".", "")}': GSTATE.ready.index});
  }

  static Future<Null> addEnc(
      {tipe, email, groupChatId, roomEmail, namaRoom}) async {
    print("asd");
    var x = await Firestore.instance
        .collection('user')
        .document(email)
        .updateData({'playwith': groupChatId}).catchError((e) {
      Fluttertoast.showToast(
          msg: "Error joining room, DM @zharfan104 at Instagram" + e);
      return "error";
    });
    x = await Firestore.instance
        .collection('$tipe')
        .document('$roomEmail $namaRoom')
        .updateData({
      'isi_room.${email.replaceAll(".", "")}': GSTATE.masuk.index
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "Error joining room, DM @zharfan104 at Instagram" + e);
      return "error";
    });
// Get document reference
    x = await Firestore.instance
        .collection('room')
        .document('$roomEmail $namaRoom')
        .updateData({'user': FieldValue.increment(1)}).catchError((e) {
      Fluttertoast.showToast(
          msg: "Error joining room, DM @zharfan104 at Instagram" + e);
      return "error";
    });
    return x;
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
      String namaRoom,
      String bab,
      String soal,
      String email,
      String tipe}) async {
    await Firestore.instance
        .collection('$tipe')
        .document('$email $namaRoom')
        .setData({'nama': namaRoom});
    await Firestore.instance
        .collection('$tipe')
        .document('$email $namaRoom')
        .updateData(
            {'isi_room.${email.replaceAll(".", "")}': GSTATE.masuk.index});
    await Firestore.instance
        .collection('room')
        .document(email + " " + namaRoom)
        .setData({
      "matpel": mapel,
      "bab": bab,
      "soal": soal,
      "nama": namaRoom,
      "email": email,
      "user": 1,
      "tipe": tipe,
      "onChat": true,
      "onPlaying": false
    });
  }
}
