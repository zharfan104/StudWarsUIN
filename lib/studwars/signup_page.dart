import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static const menuGrade = <String>['SD/MI', 'SMP/MTs', 'SMA/MA'];

  String _btnGradeSelected = "SMA/MA";

  final List<DropdownMenuItem<String>> _dropDownMenuGrade = menuGrade
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.yellow))))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.grey.shade800,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              ListTile(
                  title: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              )),
              Divider(
                color: Colors.grey.shade600,
              ),
              ListTile(
                  title: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              )),
              Divider(
                color: Colors.grey.shade600,
              ),
              ListTile(
                  title: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              )),
              Divider(
                color: Colors.grey.shade600,
              ),
              ListTile(
                  title: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              )),
              Divider(
                color: Colors.grey.shade600,
              ),
              ListTile(
                title: Text(
                  'Grade',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: DropdownButton(
                  value: _btnGradeSelected,
                  onChanged: (String newValue) {
                    setState(() {
                      _btnGradeSelected = newValue;
                    });
                  },
                  items: this._dropDownMenuGrade,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.cyan,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white70, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                child: Text(
                  'Have an account',
                  style: TextStyle(color: Colors.yellow),
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
