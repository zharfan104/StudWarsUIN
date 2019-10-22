import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/obattleroyale/battle.dart';
import 'package:flutter_firebase_login/obattleroyale/ticker.dart';
import 'package:flutter_firebase_login/oneonone/contoh_soal.dart';
import 'package:flutter_firebase_login/oneonone/question_model.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'bloc/bloc.dart';

class BattleScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String tipe;
  final String email;
  final String namaRoom;
  final List<QuestionModel> pertanyaan;

  final String roomEmail;
  BattleScreen(
      {Key key,
      @required UserRepository userRepository,
      @required this.tipe,
      @required this.roomEmail,
      @required this.email,
      @required this.namaRoom,
      @required this.pertanyaan})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<BattleBloc>(
        builder: (context) => BattleBloc(ticker: Ticker()),
        child: Battle(
          email: email,
          namaRoom: namaRoom,
          roomEmail: roomEmail,
          tipe: tipe,
          userRepository: _userRepository,
          pertanyaan: listModelPertanyaan,
        ),
      ),
    );
  }
}
