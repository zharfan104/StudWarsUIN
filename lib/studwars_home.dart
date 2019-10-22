import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/bethebestroom/bethebest.dart';
import 'package:flutter_firebase_login/constall.dart';
import 'package:flutter_firebase_login/makearoom/makearoomscreen.dart';
import 'package:flutter_firebase_login/makearoom2/makearoomscreen2.dart';
import 'package:flutter_firebase_login/makearoom3/makearoomscreen3.dart';
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
      color: krem,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new AppBar(
              elevation: 0.4,
              leading: Container(),
              centerTitle: true,
              title: new Text('Make New Room')),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
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
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Flushbar(
                    title: "Sorry,,",
                    message: "This feature is under development",
                    duration: Duration(seconds: 3),
                    flushbarPosition: FlushbarPosition.TOP,
                  ).show(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeARoomScreen2(
                                tipe: "Be The Best",
                                userRepository: _userRepository,
                              )));
                },
                child: ListItemMenu(
                  image: 'assets/best.png',
                  title: 'Be The Best',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  // Flushbar(
                  //   title: "Sorry,,",
                  //   message: "This feature is under development",
                  //   duration: Duration(seconds: 3),
                  //   flushbarPosition: FlushbarPosition.TOP,
                  // ).show(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeARoomScreen3(
                                tipe: "Battle Royale",
                                userRepository: _userRepository,
                              )));
                },
                child: ListItemMenu(
                  image: 'assets/br.png',
                  title: 'Battle Royale',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
