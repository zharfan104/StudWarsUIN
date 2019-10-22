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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'School Setting',
          style: TextStyle(color: Colors.white, fontFamily: "MonsterratBold"),
        ),
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
          if (myController.text.length == 0) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Please input your school name!',
                      style: TextStyle(fontFamily: "MonsterratBold"),
                    ),
                    Icon(
                      Icons.info,
                      color: Colors.white,
                    )
                  ],
                ),
                backgroundColor: Colors.brown,
              ),
            );
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var email = prefs.getString("email");
            print(email);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wait for a moment',
                      style: TextStyle(fontFamily: "MonsterratBold"),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
                backgroundColor: Colors.brown,
              ),
            );
            await Firestore.instance
                .collection('user')
                .document(email)
                .updateData({
              "Sekolah": myController.text,
            });
            await prefs.setString("sekolah", myController.text);
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
          }
        },
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontFamily: "MonsterratBold"),
        ));
  }
}
