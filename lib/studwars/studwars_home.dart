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
                            userRepository: _userRepository,
                          )));
            },
            child: ListItemMenu(
              image:
                  'https://images.squarespace-cdn.com/content/v1/58c83ecfd2b8571e2d227eb1/1492108477967-DH47SBVCCDNIQ3ODYGEZ/ke17ZwdGBToddI8pDm48kAvSyMu6ffSEthbwgkLVsZ57gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QHyNOqBUUEtDDsRWrJLTm_iOoQrh0-01aACSoxCNJ60HA1HmI1lPV6gQr4qkUuLWp0zIYXYt662xjIpUCMgfF/logo+lockup.jpg',
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
              image:
                  'https://www.freepnglogos.com/uploads/1-number-png/number-1-rankings-georgia-tech-40.png',
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
              image: 'https://image.flaticon.com/icons/png/512/48/48829.png',
              title: 'Battle Royale',
            ),
          )
        ],
      ),
    );
  }
}
