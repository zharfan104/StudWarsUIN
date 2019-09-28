import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/chat_room/chatroomscreen.dart';
import 'package:flutter_firebase_login/studwars/list_item_type/type_title.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import '../../UpdateFirebaseRoom.dart';

class ListItemSearch extends StatelessWidget {
  final String email;
  final String image;
  final int room;
  final String soal;
  final String mapel;
  final String nama;
  final String bab;
  final int user;
  final String tipe;
  final bool onPlaying;
  final UserRepository _userRepository;
  final String roomEmail;
  const ListItemSearch(
      {Key key,
      @required UserRepository userRepository,
      this.image,
      this.email,
      this.room,
      @required this.roomEmail,
      this.nama,
      @required this.tipe,
      this.soal,
      this.mapel,
      this.bab,
      this.onPlaying,
      this.user})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              child: Align(
                  alignment: Alignment.center, child: Image.network(image)),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MenuTitle(
                  title: '$nama',
                ),
                Text(
                  '$mapel',
                  style:
                      TextStyle(fontFamily: "MonsterratBold", fontSize: 16.0),
                ),
                Text(
                  '$bab',
                  style: TextStyle(
                      fontFamily: "MonsterratBold", color: Colors.brown[600]),
                ),
                Text(
                  '$soal',
                  style: TextStyle(
                      fontFamily: "MonsterratBold", color: Colors.brown[300]),
                ),
              ],
            ),
            SizedBox(
              width: 2.0,
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 2.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: onPlaying ? Colors.red : Colors.green,
                    child: Text(
                      onPlaying ? 'Playing' : 'Join',
                      style: TextStyle(
                          fontSize: 16.0,
                          color:
                              onPlaying ? Colors.white : Colors.tealAccent[100],
                          fontFamily: "MonsterratBold"),
                    ),
                    onPressed: () async {
                      if (onPlaying == false) {
                        UpdateFirebaseRoom.addEnc();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatroomScreen(
                                      roomEmail: roomEmail,
                                      tipe: tipe,
                                      nama_room: nama,
                                      userRepository: _userRepository,
                                      email: email,
                                      matpel: "Matematika",
                                      bab: "Aljabar",
                                      soal: "SBMPTN",
                                    )));
                      }
                    },
                  ),
                ),
                Text(
                  "${user.toString()} Player On",
                  style: TextStyle(
                      color: Colors.brown, fontFamily: "MonsterratBold"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
