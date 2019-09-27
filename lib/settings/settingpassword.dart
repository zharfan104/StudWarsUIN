import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SettingPassword extends StatefulWidget {
  @override
  _SettingPasswordState createState() => _SettingPasswordState();
}

class _SettingPasswordState extends State<SettingPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Setting'),
        backgroundColor: Colors.grey.shade800,
      ),
      body: new Pass(),
    );
  }
}

class Pass extends StatelessWidget {
  const Pass({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: InputBorder.none,
          ),
          obscureText: true,
        )),
        Divider(
          color: Colors.grey,
        ),
        ListTile(
            title: TextField(
          decoration: InputDecoration(
            hintText: "New Password",
            border: InputBorder.none,
          ),
          obscureText: true,
        )),
        Divider(
          color: Colors.grey,
        ),
        ListTile(
            title: TextField(
          decoration: InputDecoration(
            hintText: "Confirm Password",
            border: InputBorder.none,
          ),
          obscureText: true,
        )),
        Divider(
          color: Colors.grey,
        ),
        RaisedButton(
            color: Colors.grey,
            onPressed: () {
              Flushbar(
                title: "Sorry,,",
                message: "This feature is under development",
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
              ).show(context);
            },
            child: Text('Submit'))
      ],
    );
  }
}
