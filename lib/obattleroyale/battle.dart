import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/UpdateFirebaseRoom.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/oneonone/actions.dart';
import 'package:flutter_firebase_login/oneonone/question_model.dart';

import 'package:flutter_firebase_login/user_repository.dart';

import '../UpdateInGame.dart';

import 'bloc/bloc.dart';
import 'end_game.dart';

class Battle extends StatefulWidget {
  final List<QuestionModel> pertanyaan;
  final UserRepository userRepository;
  final String tipe;
  final String email;
  final String namaRoom;
  final String roomEmail;

  const Battle(
      {Key key,
      this.pertanyaan,
      this.userRepository,
      this.tipe,
      this.email,
      this.namaRoom,
      this.roomEmail})
      : super(key: key);
  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<Battle> {
  BattleBloc battleBloc;
  final Map<int, dynamic> _jawaban = {};
  int skorsoal = 0;
  bool jawab = false;
  bool isDone = true;
  @override
  void initState() {
    battleBloc = BlocProvider.of<BattleBloc>(context);
    battleBloc.dispatch(Start(
        duration: widget.pertanyaan[0].time,
        idxsoal: 0,
        isDone: false,
        lokal: 999));
    super.initState();
  }

  static const TextStyle oneTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  void dispose() {
    battleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // appBar: AppBar(title: Text('Flutter Battle')),
        body: BlocBuilder<BattleBloc, BattleState>(builder: (ctx, state) {
          final String minutesStr =
              ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
          final String secondsStr =
              (state.duration % 60).floor().toString().padLeft(2, '0');
          return Stack(
            children: <Widget>[
              Background(),
              StreamBuilder(
                  stream: Firestore.instance
                      .collection(widget.tipe)
                      .document('${widget.roomEmail} ${widget.namaRoom}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      var userDocument = snapshot.data;
                      var isi = userDocument["isi_room"];
                      var po = userDocument["poin"];
                      var so = userDocument["soal"];
                      var emailtanpatitik = widget.email.replaceAll(".", "");
                      var ja = userDocument["jawaban_soal"][emailtanpatitik];

                      Map<String, int> poin = Map<String, int>.from(po);
                      Map<String, int> isiRoom = Map<String, int>.from(isi);
                      Map<String, int> mapSoal = Map<String, int>.from(so);
                      Map<String, bool> mapJawab = Map<String, bool>.from(ja);

                      var emaillawan;
                      isiRoom.forEach((k, v) {
                        if ((v == 3 || v == 2) && (k != emailtanpatitik)) {
                          emaillawan = k;
                        } else if (k != emailtanpatitik) {
                          emaillawan = k;
                        }
                      });
                      Color btncolor;
                      Color btntxtcolor;

                      int idxsoalkamu = mapSoal[emailtanpatitik];
                      int idxsoallawan = mapSoal[emaillawan];
                      // print("$idxsoalkamu, $idxsoallawan");
                      // print("$emaillawan, $emailtanpatitik");

                      int idxsoal = mapSoal["game"];
                      // if (idxsoal > idxsoalflag) {
                      //   _playRoomoneBloc.dispatch(Reset());
                      // }

                      if (state.duration == 0 &&
                          widget.pertanyaan.length > idxsoal + 1) {
                        if (idxsoalkamu == idxsoal) {
                          UpdateInGame.answerClickedSecond(
                              incr: true,
                              idxsoal: idxsoal,
                              jawab: jawab,
                              email: emailtanpatitik,
                              emaillawan: emaillawan,
                              namaRoom: widget.namaRoom,
                              poin: 0,
                              tipe: widget.tipe,
                              roomEmail: widget.roomEmail);
                        } else {
                          UpdateInGame.updateIndex(
                              namaRoom: widget.namaRoom,
                              roomEmail: widget.roomEmail,
                              tipe: widget.tipe);
                        }

                        battleBloc.dispatch(Start(
                            duration: widget.pertanyaan[idxsoal].time,
                            idxsoal: idxsoal,
                            lokal: 999,
                            isDone: false));
                      }

                      var poinLawan = 0;
                      var poinKamu = 0;

                      // var indexsoal = mapSoal[emailtanpatitik];

                      QuestionModel soal = widget.pertanyaan[idxsoal];
                      final List<dynamic> opsi = soal.jwbSalah;
                      if (!opsi.contains(soal.jwbBenar)) {
                        opsi.add(soal.jwbBenar);
                        opsi.shuffle();
                      }

                      poinKamu = poin[emailtanpatitik];
                      poinLawan = poin[emaillawan];
                      if (state.duration == 0 &&
                          widget.pertanyaan.length == idxsoal + 1) {
                        if (!state.isDone) {
                          UpdateFirebaseRoom.donePlay(
                              isWin: poinKamu > poinLawan, email: widget.email);
                        }

                        battleBloc.dispatch(Start(
                            duration: 999999,
                            idxsoal: idxsoal,
                            lokal: 999,
                            isDone: true));
                      }
                      if (state.lokal == idxsoal) {
                        // UpdateFirebaseRoom.donePlay(email: widget.email);

                        battleBloc.dispatch(Start(
                            duration: widget.pertanyaan[idxsoal].time,
                            idxsoal: idxsoal,
                            lokal: 999,
                            isDone: false));
                      }
                      if ((idxsoalkamu == idxsoallawan) &&
                          (idxsoalkamu == idxsoal + 1) &&
                          (widget.pertanyaan.length == idxsoal + 1)) {
                        if (state.isDone) {
                          UpdateFirebaseRoom.donePlay(
                              email: widget.email,
                              isWin: (poinKamu > poinLawan));
                        }

                        battleBloc.dispatch(Start(
                            duration: 999999,
                            idxsoal: idxsoal,
                            lokal: 999,
                            isDone: true));
                      }

                      if (state.isDone) {
                        return EndGame(
                            email: widget.email,
                            namaRoom: widget.namaRoom,
                            roomEmail: widget.roomEmail,
                            tipe: widget.tipe,
                            userRepository: widget.userRepository,
                            poinkamu: poinKamu,
                            poinlawan: poinLawan,
                            jawaban: mapJawab,
                            pertanyaan: widget.pertanyaan);
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).padding.top + 10,
                            ),
                            Container(
                              height: MediaQuery.of(context).padding.top + 10,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.grey.shade800,
                                    ),
                                    onPressed: _onWillPop,
                                  ),
                                  Text(
                                    "Aljabar - Matematika",
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontFamily: "MonsterratBold",
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.0),
                              child: Center(
                                  child: Text(
                                '$minutesStr:$secondsStr',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40.0),
                              )),
                            ),
                            Container(
                                child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(
                                          child: Card(
                                            color: (poinKamu > poinLawan)
                                                ? Colors.green
                                                : Colors.orange,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 8.0),
                                                child: Center(
                                                  child: Text(
                                                    'Your Point : $poinKamu',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          child: Card(
                                            color: (poinLawan > poinKamu)
                                                ? Colors.green
                                                : Colors.orange,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 8.0),
                                              child: Center(
                                                  child: Text(
                                                'Opponent : $poinLawan',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.16,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                            ),
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: AutoSizeText(
                                                soal.pertanyaan,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                    fontFamily:
                                                        "MonsterratBold"),
                                              ),
                                            )),
                                          ),
                                          Positioned(
                                              right: 12.0,
                                              bottom: 12.0,
                                              child: CircleAvatar(
                                                maxRadius: 10,
                                                backgroundColor:
                                                    Colors.grey.shade800,
                                                child: Text(
                                                  "${idxsoal + 1}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "MonsterratBold",
                                                      fontSize: 18.0,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                (idxsoalkamu > idxsoal)
                                    ? Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Container(
                                            width: double.infinity,
                                            height: 100.0,
                                            child: Center(
                                              child: Column(
                                                children: <Widget>[
                                                  jawab
                                                      ? Text(
                                                          "Hoooorayy...",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20.0,
                                                              fontFamily:
                                                                  "MonsterratBold"),
                                                        )
                                                      : Text(
                                                          "The correct answer is ${widget.pertanyaan[idxsoal].jwbBenar}",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 20.0,
                                                              fontFamily:
                                                                  "MonsterratBold"),
                                                        ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  jawab
                                                      ? Text(
                                                          "Your answer is correct. +$skorsoal",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0,
                                                              fontFamily:
                                                                  "MonsterratBold"),
                                                        )
                                                      : Text(
                                                          "Your answer is incorrect. You got no point",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0,
                                                              fontFamily:
                                                                  "MonsterratBold")),
                                                ],
                                              ),
                                            )),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(children: <Widget>[
                                            ...opsi.map((pilihan) {
                                              if (_jawaban[idxsoal] ==
                                                  pilihan) {
                                                btncolor = Colors.white;
                                                btntxtcolor = Colors.black;
                                              } else {
                                                btncolor = Colors.grey.shade900;
                                                btntxtcolor = Colors.white;
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Material(
                                                  color: btncolor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                    onTap: () {
                                                      setState(() {
                                                        _jawaban[idxsoal] =
                                                            pilihan;
                                                        print(_jawaban);
                                                      });
                                                    },
                                                    child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        width: double.infinity,
                                                        child: Center(
                                                            child: Text(
                                                                '$pilihan',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "MonsterratBold",
                                                                    color:
                                                                        btntxtcolor)))),
                                                  ),
                                                ),
                                              );
                                            })
                                          ]),
                                        ),
                                      ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                (idxsoalkamu > idxsoal)
                                    ? Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                            Color>(
                                                        Colors.blueAccent),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              "  Waiting for opponent to answer...",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "MonsterratBold",
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    : FloatingActionButton.extended(
                                        onPressed: () async {
                                          print("$idxsoallawan $idxsoalkamu");
                                          print("$emaillawan $emailtanpatitik");

                                          setState(() {
                                            if (_jawaban[idxsoal] ==
                                                widget.pertanyaan[idxsoal]
                                                    .jwbBenar) {
                                              jawab = true;
                                              skorsoal = state.duration;
                                            } else {
                                              jawab = false;
                                              skorsoal = 0;
                                            }
                                          });

                                          if (idxsoalkamu < idxsoallawan) {
                                            if (widget.pertanyaan.length <=
                                                idxsoal + 1) {
                                              await UpdateInGame
                                                  .answerClickedSecond(
                                                      incr: false,
                                                      idxsoal: idxsoal,
                                                      jawab: jawab,
                                                      email: widget.email
                                                          .replaceAll(".", ""),
                                                      namaRoom: widget.namaRoom,
                                                      poin: skorsoal,
                                                      tipe: widget.tipe,
                                                      emaillawan: emaillawan,
                                                      roomEmail:
                                                          widget.roomEmail);
                                              UpdateFirebaseRoom.donePlay(
                                                  isWin: (poinKamu > poinLawan),
                                                  email: widget.email);

                                              battleBloc.dispatch(Start(
                                                  lokal: 999,
                                                  duration: 99999,
                                                  idxsoal: idxsoal,
                                                  isDone: true));
                                            } else {
                                              print("asu");
                                              await UpdateInGame
                                                  .answerClickedSecond(
                                                      incr: true,
                                                      idxsoal: idxsoal,
                                                      jawab: jawab,
                                                      email: widget.email
                                                          .replaceAll(".", ""),
                                                      namaRoom: widget.namaRoom,
                                                      poin: skorsoal,
                                                      tipe: widget.tipe,
                                                      emaillawan: emaillawan,
                                                      roomEmail:
                                                          widget.roomEmail);

                                              battleBloc.dispatch(Start(
                                                  duration: widget
                                                      .pertanyaan[idxsoal + 1]
                                                      .time,
                                                  isDone: false,
                                                  lokal: 9999,
                                                  idxsoal: idxsoal));
                                            }
                                          } else {
                                            if (widget.pertanyaan.length ==
                                                idxsoal + 1) {
                                              UpdateInGame.answerClickedFirst(
                                                  idxsoal: idxsoal,
                                                  jawab: jawab,
                                                  email: emailtanpatitik,
                                                  namaRoom: widget.namaRoom,
                                                  poin: skorsoal,
                                                  tipe: widget.tipe,
                                                  emaillawan: emaillawan,
                                                  roomEmail: widget.roomEmail);
                                              // UpdateFirebaseRoom.donePlay(
                                              //     email: widget.email);

                                              battleBloc.dispatch(Start(
                                                  lokal: idxsoal + 1,
                                                  duration: state.duration,
                                                  idxsoal: idxsoal,
                                                  isDone: false));
                                            } else {
                                              UpdateInGame.answerClickedFirst(
                                                  idxsoal: idxsoal,
                                                  jawab: jawab,
                                                  email: emailtanpatitik,
                                                  namaRoom: widget.namaRoom,
                                                  poin: skorsoal,
                                                  tipe: widget.tipe,
                                                  emaillawan: emaillawan,
                                                  roomEmail: widget.roomEmail);
                                              battleBloc.dispatch(Start(
                                                  lokal: idxsoal + 1,
                                                  duration: state.duration,
                                                  idxsoal: idxsoal,
                                                  isDone: false));
                                            }
                                          }
                                        },
                                        tooltip: "Submit Your Answer",
                                        backgroundColor: Colors.black,
                                        icon: Icon(Icons.check),
                                        label: Text("Submit Answer"),
                                      ),
                              ],
                            )),
                          ],
                        );
                      }
                    }
                  }),
            ],
          );
        }),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure..?'),
            content: new Text('Do you want to exit the room?  '),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  UpdateFirebaseRoom.exitRoom(
                      tipe: widget.tipe,
                      email: widget.email,
                      namaRoom: widget.namaRoom,
                      roomEmail: widget.roomEmail);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => App(
                                userRepository: widget.userRepository,
                              )));
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        battleBloc: BlocProvider.of<BattleBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    BattleBloc battleBloc,
  }) {
    final BattleState state = battleBloc.currentState;
    if (state is Ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => battleBloc.dispatch(Start(
              duration: state.duration,
              idxsoal: 3,
              lokal: state.lokal,
              isDone: false)),
        ),
      ];
    }
    if (state is Running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => battleBloc.dispatch(Pause()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => battleBloc.dispatch(Reset()),
        ),
      ];
    }
    if (state is Paused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => battleBloc.dispatch(Resume()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => battleBloc.dispatch(Reset()),
        ),
      ];
    }
    if (state is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => battleBloc.dispatch(Reset()),
        ),
      ];
    }
    return [];
  }
}
