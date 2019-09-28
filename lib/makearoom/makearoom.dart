import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chat_room/chatroomscreen.dart';
import 'package:flutter_firebase_login/dropdownsoal.dart';
import 'package:flutter_firebase_login/makearoom/bloc/makearoom_bloc.dart';
import 'package:flutter_firebase_login/makearoom/bloc/makearoom_state.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc.dart';

class MakeARoom extends StatefulWidget {
  UserRepository _userRepository;
  String _tipe;
  MakeARoom(
      {Key key, @required UserRepository userRepository, @required String tipe})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _tipe = tipe,
        super(key: key);
  @override
  _MakeARoomState createState() => _MakeARoomState();
}

class _MakeARoomState extends State<MakeARoom> {
  MakeARoomBloc _makeARoomBloc;

  UserRepository get _userRepository => widget._userRepository;
  String get _tipe => widget._tipe;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _makeARoomBloc = BlocProvider.of<MakeARoomBloc>(context);
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();

    _makeARoomBloc.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  static const mapelGrade = <String>[
    'Matematika',
    'Fisika',
    'Kimia',
    'Biologi'
  ];
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

  final List<DropdownMenuItem<String>> _dropDownMenuUjian = jenisUjian
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: TextStyle(
                  color: Colors.black, fontFamily: "MonsterratBold"))))
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

      if (state.isGo) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatroomScreen(
                      roomEmail: state.email,
                      tipe: _tipe,
                      nama_room: myController.text,
                      userRepository: _userRepository,
                      email: state.email,
                      bab: state.bab,
                      matpel: state.matpel,
                      soal: _soal,
                    )));
      }
    }, child:
        BlocBuilder<MakeARoomBloc, MakeARoomState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
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
              style: TextStyle(color: Colors.white, fontSize: 40),
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
                  "Nama Room",
                  style: TextStyle(
                      color: Colors.tealAccent[200],
                      fontFamily: "MonsterratBold",
                      fontSize: 15.0),
                ),
              ),
              SizedBox(
                width: 40.0,
              ),
              Container(
                width: 150.0,
                child: new TextFormField(
                  controller: myController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
                    hintText: "Type here",

                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid, color: Colors.white),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                          style: BorderStyle.solid, color: Colors.white),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ],
          )),
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
                      style: TextStyle(fontFamily: "MonsterratBold"),
                      value: state.matpel,
                      onChanged: (String newValue) {
                        _makeARoomBloc.dispatch(MatpelChanged(
                            matpel: newValue,
                            bab: matpeltodropvalue(newValue)));
                      },
                      items: arrtodropdown(matpelwithoutsemua)),
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
                      style: TextStyle(fontFamily: "MonsterratBold"),
                      value: state.bab,
                      onChanged: (String newValue) {
                        _makeARoomBloc.dispatch(BabChanged(bab: newValue));
                      },
                      items: arrtodropdownmatpel(state.matpel)),
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
            color: Colors.brown[600],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              if (myController.text.length > 0) {
                _makeARoomBloc.dispatch(BuatRoomPressed(
                  nama_room: myController.text,
                  bab: state.bab,
                  tipe: _tipe,
                  mapel: state.matpel,
                  soal: state.soal,
                  email: state.email,
                ));
              } else {
                Flushbar(
                  title: "Room name is required,,",
                  message: "Please insert room name",
                  duration: Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                ).show(context);
              }
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Buat Room Baru', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      );
    }));
  }
}
