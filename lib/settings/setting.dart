import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_firebase_login/authentication_bloc/authentication_event.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/settings/settingpassword.dart';
import 'package:flutter_firebase_login/settings/settingschool.dart';
import 'package:flutter_firebase_login/settings/settingusername.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Setting extends StatefulWidget {
  final UserRepository _userRepository;

  Setting({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  UserRepository get _userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Colors.grey.shade800,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingUsername()));
            },
            leading: Icon(Icons.account_box),
            title: Text('Username'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingSchool()));
            },
            leading: Icon(Icons.account_balance),
            title: Text('School'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPassword()));
            },
            leading: Icon(Icons.lock),
            title: Text('Password'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Flushbar(
                title: "Sorry,,",
                message: "This feature is under development",
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
              ).show(context);
            },
            leading: Icon(Icons.help),
            title: Text('Bantuan dan Masukkan'),
          ),
          ListTile(
            onTap: () {
              Flushbar(
                title: "Sorry,,",
                message: "This feature is under development",
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
              ).show(context);
            },
            leading: Icon(Icons.info),
            title: Text('Tentang'),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).dispatch(
                  LoggedOut(),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => App(
                              userRepository: _userRepository,
                            )));
              },
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Keluar',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "MonsterratBold"),
                    ),
                  ],
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
