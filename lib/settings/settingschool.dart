import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingSchool extends StatefulWidget {
  @override
  _SettingSchoolState createState() => _SettingSchoolState();
}

class _SettingSchoolState extends State<SettingSchool> {
  final myController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Setting'),
        backgroundColor: Colors.grey.shade800,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
              title: TextField(
            controller: myController,
            decoration: InputDecoration(
              hintText: "Change School",
              border: InputBorder.none,
            ),
          )),
          Divider(
            color: Colors.grey,
          ),
          new Tombolnya(myController: myController)
        ],
      ),
    );
  }
}

class Tombolnya extends StatelessWidget {
  const Tombolnya({
    Key key,
    @required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.green,
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var email = prefs.getString("email");
          Firestore.instance.collection('user').document(email).updateData({
            "sekolah": myController.text,
          });
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'School has changed!',
                    style: TextStyle(fontFamily: "MonsterratBold"),
                  ),
                  Icon(Icons.check_circle)
                ],
              ),
              backgroundColor: Colors.brown,
            ),
          );
        },
        child: Text('Submit'));
  }
}
