import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chat_room/bloc/chatroom_bloc.dart';
import 'package:flutter_firebase_login/chat_room/chat.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/user_repository.dart';

class ChatroomScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String _email;
  final String _bab;
  final String _matpel;
  final String _soal;
  final String _tipe;
  final String _nama_room;
  final String _roomEmail;
  ChatroomScreen(
      {Key key,
      @required UserRepository userRepository,
      @required String email,
      @required String bab,
      @required String roomEmail,
      @required String nama_room,
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
        _nama_room = nama_room,
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
                    Firestore.instance
                        .collection('user')
                        .document(_email)
                        .updateData({'playwith': "null"});

                    Firestore.instance
                        .collection('room')
                        .document('$_nama_room-$_roomEmail')
                        .updateData({'user': FieldValue.increment(-1)});

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
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: RaisedButton(
                color: Colors.teal[300],
                onPressed: () {},
                child: Text(
                  "Ready",
                  style: TextStyle(fontFamily: "MonsterratBold"),
                ),
              ),
            )
          ],
          title: Text(
            "$_nama_room",
            style: TextStyle(color: Colors.black, fontFamily: "MonsterratBold"),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: _onWillPop,
          ),
        ),
        body: BlocProvider<ChatroomBloc>(
          builder: (context) => ChatroomBloc(userRepository: _userRepository),
          child: Chat(
            roomEmail: _roomEmail,
            userRepository: _userRepository,
            tipe: _tipe,
            nama_room: _nama_room,
            bab: _bab,
            email: _email,
            matpel: _matpel,
            soal: _soal,
            peerAvatar:
                "https://www.telegraph.co.uk/content/dam/men/2017/08/01/TELEMMGLPICT000135625787_trans_NvBQzQNjv4Bq2lilFKyV0mnRbDqhBKaO25ZHuHhHLN-rNkYJ4-8VlCg.jpeg",
            peerId: "kucing@gmail.com",
          ),
        ),
      ),
    );
  }
}
