import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_listview/easy_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/dropdownsoal.dart';
import 'package:flutter_firebase_login/find_room/bloc/bloc.dart';
import 'package:flutter_firebase_login/list_item_type/list_item_search.dart';
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
  String tipe, image;
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
            new AppBar(
                elevation: 0.4,
                leading: Container(),
                centerTitle: true,
                title: new Text('Find Room')),
            buildPilihan(state),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (state.matpel == "Semua" && state.bab == "Semua")
                    ? Firestore.instance
                        .collection('room')
                        // .orderBy("user", descending: true)
                        .snapshots()
                    : (state.matpel == "Semua")
                        ? Firestore.instance
                            .collection('room')
                            .where("bab", isEqualTo: state.bab)
                            .snapshots()
                        : (state.bab == "Semua")
                            ? Firestore.instance
                                .collection('room')
                                .where("matpel", isEqualTo: state.matpel)
                                .snapshots()
                            : Firestore.instance
                                .collection('room')
                                .where("matpel", isEqualTo: state.matpel)
                                .where("bab", isEqualTo: state.bab)
                                .snapshots(),
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
                      print(state.matpel);

                      print(state.soal);
                      if (snapshot.data.documents.length == 0) {
                        return Center(
                            child: Text("Room Not Found",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontFamily: "MonsterratBold",
                                    fontSize: 20.0)));
                      } else {
                        return EasyListView(
                          scrollbarEnable: false,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            tipe = snapshot.data.documents[index]["tipe"];

                            if (tipe == "One On One") {
                              image = 'assets/one.png';
                            } else if (tipe == "Be The Best") {
                              image = 'assets/best.png';
                            } else {
                              image = 'assets/br.png';
                            }
                            return ListItemSearch(
                                nama: snapshot.data.documents[index]["nama"],
                                tipe: tipe,
                                userRepository: _userRepository,
                                email: _email ?? "zharfan.akbar104@gmail.com",
                                roomEmail: snapshot.data.documents[index]
                                    ["email"],
                                user:
                                    snapshot.data.documents[index]["user"] ?? 0,
                                image:
                                    'https://images.squarespace-cdn.com/content/v1/58c83ecfd2b8571e2d227eb1/1492108477967-DH47SBVCCDNIQ3ODYGEZ/ke17ZwdGBToddI8pDm48kAvSyMu6ffSEthbwgkLVsZ57gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QHyNOqBUUEtDDsRWrJLTm_iOoQrh0-01aACSoxCNJ60HA1HmI1lPV6gQr4qkUuLWp0zIYXYt662xjIpUCMgfF/logo+lockup.jpg',
                                room: index + 1,
                                soal: snapshot.data.documents[index]["soal"] ??
                                    "SBMPTN",
                                mapel: snapshot.data.documents[index]
                                        ["matpel"] ??
                                    "Fisika",
                                bab: snapshot.data.documents[index]["bab"] ??
                                    "Dinamika",
                                onPlaying: snapshot.data.documents[index]
                                        ["onPlaying"] ??
                                    false);
                          },
                        );
                      }
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
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
