import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chat_room/chat_room.dart';
import 'package:flutter_firebase_login/chat_room/chatroomscreen.dart';
import 'package:flutter_firebase_login/makearoom/bloc/makearoom_bloc.dart';
import 'package:flutter_firebase_login/makearoom/bloc/makearoom_state.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc.dart';

class MakeARoom extends StatefulWidget {
  UserRepository _userRepository;
  MakeARoom({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _MakeARoomState createState() => _MakeARoomState();
}

class _MakeARoomState extends State<MakeARoom> {
  MakeARoomBloc _makeARoomBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _makeARoomBloc = BlocProvider.of<MakeARoomBloc>(context);
  }

  static const mapelGrade = <String>[
    'Matematika',
    'Fisika',
    'Kimia',
    'Biologi'
  ];
  bool _private = false;
  String _mapel = "Matematika";

  static const jenisUjian = <String>['SIMAK UI', 'SBMPTN', 'UM'];
  String _soal = "SBMPTN";

  static const subMapel = <String>[
    'Aljabar',
    'Trigonometri',
    'Bangun Ruang',
    'Fungsi'
  ];
  String _bab = "Aljabar";

  final List<DropdownMenuItem<String>> _dropDownMenuMapel = mapelGrade
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black))))
      .toList();

  final List<DropdownMenuItem<String>> _dropDownMenuUjian = jenisUjian
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black))))
      .toList();

  final List<DropdownMenuItem<String>> _dropDownMenuSubmapel = subMapel
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black))))
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MakeARoomBloc, MakeARoomState>(listener:
        (context, state) {
      if (state.isSubmitting) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Create Room...'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
      }
      if (state.isSuccess) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Room Created',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.check_circle),
                ],
              ),
              backgroundColor: Colors.brown,
            ),
          );
        print("kucing");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatroomScreen(
                      userRepository: _userRepository,
                      email: state.email,
                    )));
      }
    }, child:
        BlocBuilder<MakeARoomBloc, MakeARoomState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.greenAccent[500],
            height: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.tealAccent[100],
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Center(
                  child: Text(
                    "Buat Room Baru",
                    style: TextStyle(
                        color: Colors.tealAccent[100],
                        fontSize: 30.0,
                        fontFamily: "MonsterratBold"),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "1 Lawan 1",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Mata Pelajaran",
                  style: TextStyle(
                      color: Colors.tealAccent[200],
                      fontFamily: "MonsterratBold",
                      fontSize: 15.0),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: DropdownButton(
                    value: _mapel,
                    onChanged: (String newValue) {
                      setState(() {
                        _mapel = newValue;
                      });
                    },
                    items: this._dropDownMenuMapel,
                  ),
                ),
              ),
            ],
          )),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Bab",
                  style: TextStyle(
                      color: Colors.tealAccent[200],
                      fontFamily: "MonsterratBold",
                      fontSize: 15.0),
                ),
              ),
              SizedBox(
                width: 105.0,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: DropdownButton(
                    value: _bab,
                    onChanged: (String newValue) {
                      setState(() {
                        _bab = newValue;
                      });
                    },
                    items: this._dropDownMenuSubmapel,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Soal",
                  style: TextStyle(
                      color: Colors.tealAccent[200],
                      fontFamily: "MonsterratBold",
                      fontSize: 15.0),
                ),
              ),
              SizedBox(
                width: 105.0,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: DropdownButton(
                    value: _soal,
                    onChanged: (String newValue) {
                      setState(() {
                        _soal = newValue;
                      });
                    },
                    items: this._dropDownMenuUjian,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            onPressed: () {
              _makeARoomBloc.dispatch(
                  BuatRoomPressed(bab: _bab, mapel: _mapel, soal: _soal));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              color: Colors.brown[600],
              padding: const EdgeInsets.all(10.0),
              child:
                  const Text('Buat Room Baru', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      );
    }));
  }
}
