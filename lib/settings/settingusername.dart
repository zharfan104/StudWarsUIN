import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingUsername extends StatefulWidget {
  @override
  _SettingUsernameState createState() => _SettingUsernameState();
}

class _SettingUsernameState extends State<SettingUsername> {
  final myController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username Setting'),
        backgroundColor: Colors.grey.shade800,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
              title: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            controller: myController,
            decoration: InputDecoration(
              hintText: "Type Your New Username Here",
              border: InputBorder.none,
            ),
          )),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          new Tombol(myController: myController)
        ],
      ),
    );
  }
}

class Tombol extends StatelessWidget {
  const Tombol({
    Key key,
    @required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.grey,
        onPressed: () async {
          if (myController.text.length <= 10 && myController.text.length > 0) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var email = prefs.getString("email");
            Firestore.instance.collection('user').document(email).updateData({
              "nama": myController.text,
            });
            await prefs.setString("nama", myController.text);

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Username has changed!',
                      style: TextStyle(fontFamily: "MonsterratBold"),
                    ),
                    Icon(Icons.check_circle)
                  ],
                ),
                backgroundColor: Colors.brown,
              ),
            );
          } else {
            Flushbar(
              title: "Username Salah",
              message: "Username harus kurang dari 10 Karakter",
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
            ).show(context);
          }
        },
        child: Text('Submit'));
  }
}
