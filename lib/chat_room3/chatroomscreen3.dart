import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/UpdateFirebaseRoom.dart';
import 'package:flutter_firebase_login/chat_room3/bloc/bloc.dart';
import 'package:flutter_firebase_login/chat_room/chat.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/user_repository.dart';

class ChatroomScreen3 extends StatelessWidget {
  final UserRepository _userRepository;
  final String _email;
  final String _bab;
  final String _matpel;
  final String _soal;
  final String _tipe;
  final String _namaRoom;
  final int _user;
  final String _roomEmail;
  ChatroomScreen3(
      {Key key,
      @required UserRepository userRepository,
      @required String email,
      @required int user,
      @required String roomEmail,
      @required String bab,
      @required String namaRoom,
      @required String matpel,
      @required String tipe,
      @required String soal})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _email = email,
        _bab = bab,
        _matpel = matpel,
        _tipe = tipe,
        _soal = soal,
        _namaRoom = namaRoom,
        _user = user,
        _roomEmail = roomEmail,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the room?  '),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () {
                    UpdateFirebaseRoom.exitRoom(
                        tipe: _tipe,
                        email: _email,
                        namaRoom: _namaRoom,
                        roomEmail: _roomEmail);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => App(
                                  userRepository: _userRepository,
                                )));
                  },
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    print(_email);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocProvider<ChatroomBloc3>(
        builder: (context) => ChatroomBloc3(
            // userRepository: _userRepository,
            // namaRoom: _namaRoom,
            // roomEmail: _roomEmail,
            ),
        child: Chat(
          user: _user,
          roomEmail: _roomEmail,
          userRepository: _userRepository,
          tipe: _tipe,
          namaRoom: _namaRoom,
          bab: _bab,
          email: _email,
          matpel: _matpel,
          soal: _soal,
          peerAvatar:
              "https://www.telegraph.co.uk/content/dam/men/2017/08/01/TELEMMGLPICT000135625787_trans_NvBQzQNjv4Bq2lilFKyV0mnRbDqhBKaO25ZHuHhHLN-rNkYJ4-8VlCg.jpeg",
          peerId: "kucing@gmail.com",
        ),
      ),
    );
  }
}
