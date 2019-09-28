import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/battleroyale/battleroyale.dart';
import 'package:flutter_firebase_login/bethebestroom/bethebest.dart';
import 'package:flutter_firebase_login/makearoom/makearoomscreen.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'list_item_type/list_item_menu.dart';

class StudwarsHome extends StatelessWidget {
  UserRepository _userRepository;
  StudwarsHome({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppBar(
            title: Center(
              child: Text(
                'New Room',
                style: TextStyle(
                    fontFamily: "MonsterratBold",
                    color: Colors.tealAccent[200]),
              ),
            ),
            backgroundColor: Colors.brown[400],
            centerTitle: true,
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MakeARoomScreen(
                            tipe: "One On One",
                            userRepository: _userRepository,
                          )));
            },
            child: ListItemMenu(
              image: 'assets/one.png',
              title: 'One on One',
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              // Flushbar(
              //   title: "Sorry,,",
              //   message: "This feature is under development",
              //   duration: Duration(seconds: 3),
              //   flushbarPosition: FlushbarPosition.TOP,
              // ).show(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BeTheBest()));
            },
            child: ListItemMenu(
              image: 'assets/best.png',
              title: 'Be The Best',
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              Flushbar(
                title: "Sorry,,",
                message: "This feature is under development",
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
              ).show(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BattleRoyale()));
            },
            child: ListItemMenu(
              image: 'assets/br.png',
              title: 'Battle Royale',
            ),
          )
        ],
      ),
    );
  }
}
