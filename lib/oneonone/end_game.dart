import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/UpdateFirebaseRoom.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/oneonone/kunci_jawaban.dart';
import 'package:flutter_firebase_login/oneonone/question_model.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'contoh_soal.dart';

class EndGame extends StatelessWidget {
  final List<QuestionModel> pertanyaan;
  final Map<String, bool> jawaban;
  final int poinkamu;
  final UserRepository userRepository;
  final String tipe;
  final String email;
  final String namaRoom;
  final String roomEmail;
  final int poinlawan;

  EndGame(
      {Key key,
      @required this.pertanyaan,
      @required this.jawaban,
      @required this.poinkamu,
      @required this.userRepository,
      @required this.poinlawan,
      @required this.tipe,
      @required this.email,
      @required this.namaRoom,
      @required this.roomEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    this.jawaban.forEach((index, value) {
      if (value == true) correct++;
    });
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        leading: Icon(
          Icons.info,
          color: Colors.white,
        ),
        title: (poinkamu > poinlawan)
            ? AutoSizeText(
                'Congratulation, You Win!',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: "MonsterratBold"),
              )
            : AutoSizeText(
                'Sorry, you lost !',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: "MonsterratBold"),
              ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent.shade400, Colors.white70],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Total Questions", style: titleStyle),
                  trailing: Text("${pertanyaan.length}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Validation Rate", style: titleStyle),
                  trailing: Text("${correct / pertanyaan.length * 100}%",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Your Final Point", style: titleStyle),
                  trailing: Text("$poinkamu", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Your Opponent Point", style: titleStyle),
                  trailing: Text("$poinlawan", style: trailingStyle),
                ),
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.deepPurple.withOpacity(0.8),
                      textColor: Colors.white,
                      child: Text("Answer Key"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => KunciJawaban(
                                  pertanyaan: pertanyaan,
                                  jawaban: jawabanBenar,
                                )));
                      },
                    ),
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.pink.withOpacity(0.8),
                    textColor: Colors.white,
                    child: Text("Back To Main Menu"),
                    onPressed: () {
                      UpdateFirebaseRoom.exitRoom(
                          tipe: tipe,
                          email: email,
                          namaRoom: namaRoom,
                          roomEmail: roomEmail);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => App(
                                userRepository: userRepository,
                              )));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
