import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_listview/easy_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/dropdownsoal.dart';
import 'package:flutter_firebase_login/find_room/bloc/bloc.dart';
import 'package:flutter_firebase_login/studwars/list_item_type/list_item_search.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindRoom extends StatefulWidget {
  final UserRepository _userRepository;

  FindRoom({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _FindRoomState createState() => _FindRoomState();
}

List<DropdownMenuItem<String>> a;
List<DropdownMenuItem<String>> b;
List<DropdownMenuItem<String>> c;

class _FindRoomState extends State<FindRoom> {
  FindRoomBloc _findRoomBloc;
  UserRepository get _userRepository => widget._userRepository;
  String _email;
  @override
  void initState() {
    _getEmail();

    super.initState();
    _findRoomBloc = BlocProvider.of<FindRoomBloc>(context);
  }

  _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString("email");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRoomBloc, FindRoomState>(
      builder: (context, state) {
        print(state.bab);
        return Column(
          children: <Widget>[
            AppBar(
              title: Center(
                child: Text(
                  'Find Room',
                  style: TextStyle(
                      fontFamily: "MonsterratBold",
                      color: Colors.tealAccent[200]),
                ),
              ),
              backgroundColor: Colors.brown[600],
              centerTitle: true,
            ),
            Divider(),
            buildPilihan(state),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('room').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.brown,
                          ),
                        ),
                      );
                    default:
                      return EasyListView(
                        scrollbarEnable: false,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return ListItemSearch(
                              nama: snapshot.data.documents[index]["nama"],
                              tipe: snapshot.data.documents[index]["tipe"],
                              userRepository: _userRepository,
                              email: _email ?? "zharfan.akbar104@gmail.com",
                              roomEmail: snapshot.data.documents[index]
                                  ["email"],
                              user: snapshot.data.documents[index]["user"] ?? 0,
                              image:
                                  'https://images.squarespace-cdn.com/content/v1/58c83ecfd2b8571e2d227eb1/1492108477967-DH47SBVCCDNIQ3ODYGEZ/ke17ZwdGBToddI8pDm48kAvSyMu6ffSEthbwgkLVsZ57gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QHyNOqBUUEtDDsRWrJLTm_iOoQrh0-01aACSoxCNJ60HA1HmI1lPV6gQr4qkUuLWp0zIYXYt662xjIpUCMgfF/logo+lockup.jpg',
                              room: index + 1,
                              soal: snapshot.data.documents[index]["soal"] ??
                                  "SBMPTN",
                              mapel: snapshot.data.documents[index]["matpel"] ??
                                  "Fisika",
                              bab: snapshot.data.documents[index]["bab"] ??
                                  "Dinamika",
                              onPlaying: snapshot.data.documents[index]
                                      ["onPlaying"] ??
                                  false);
                        },
                      );
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }

  Container buildPilihan(FindRoomState state) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.tealAccent[1000]),
      child: Row(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: 150,
                      child: DropdownButton(
                          style: TextStyle(fontFamily: "MonsterratBold"),
                          value: state.matpel,
                          onChanged: (String newValue) {
                            _findRoomBloc.dispatch(MatpelChanged(
                                matpel: newValue,
                                bab: matpeltodropvalue(newValue)));
                          },
                          items: arrtodropdown(matpel)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Card(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 170,
                        child: DropdownButton(
                            style: TextStyle(fontFamily: "MonsterratBold"),
                            value: state.bab,
                            onChanged: (String newValue) {
                              _findRoomBloc.dispatch(BabChanged(bab: newValue));
                            },
                            items: arrtodropdownmatpel(state.matpel)),
                      )),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: Colors.brown,
                      onChanged: (bool value) {
                        _findRoomBloc.dispatch(OboChanged(obo: value));
                      },
                      value: state.obo,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'One By One',
                      style: TextStyle(color: Colors.brown[800]),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButton(
                      style: TextStyle(fontFamily: "MonsterratBold"),
                      value: state.soal,
                      onChanged: (String newValue) {
                        _findRoomBloc.dispatch(SoalChanged(soal: newValue));
                      },
                      items: arrtodropdown(soal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: Colors.brown,
                      onChanged: (bool value) {
                        _findRoomBloc.dispatch(BtbChanged(btb: value));
                      },
                      value: state.btb,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Be The Best',
                      style: TextStyle(color: Colors.brown[800]),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: Colors.brown,
                      onChanged: (bool value) {
                        setState(() {
                          _findRoomBloc.dispatch(BrChanged(br: value));
                        });
                      },
                      value: state.br,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Battle Royal',
                      style: TextStyle(color: Colors.brown[800]),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<Null> _handleRefresh() async {
  await new Future.delayed(new Duration(seconds: 2));
  return null;
}
