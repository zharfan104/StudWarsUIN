import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/chat_room/chatroomscreen.dart';
import 'package:flutter_firebase_login/list_item_type/type_title.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../UpdateFirebaseRoom.dart';

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
              child:
                  Align(alignment: Alignment.center, child: Image.asset(image)),
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
                    color:
                        (onPlaying || (user >= 2)) ? Colors.red : Colors.green,
                    child: Text(
                      (onPlaying || (user >= 2)) ? 'Full' : 'Join',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: (onPlaying || (user >= 2))
                              ? Colors.white
                              : Colors.tealAccent[100],
                          fontFamily: "MonsterratBold"),
                    ),
                    onPressed: () async {
                      if (onPlaying || (user >= 2)) {
                        Fluttertoast.showToast(msg: "Room Full");
                      } else {
                        Scaffold.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Joining room..'),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          );

                        var x = await UpdateFirebaseRoom.addEnc(
                            tipe: tipe,
                            email: email,
                            groupChatId: "$nama-$roomEmail",
                            roomEmail: roomEmail,
                            namaRoom: nama);
                        if (x != "error") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatroomScreen(
                                        user: user,
                                        roomEmail: roomEmail,
                                        tipe: tipe,
                                        namaRoom: nama,
                                        userRepository: _userRepository,
                                        email: email,
                                        matpel: "Matematika",
                                        bab: "Aljabar",
                                        soal: "SBMPTN",
                                      )));
                        }
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
