import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/list_item_type/list_item_leaderboard.dart';

class StudwarsLeaderboard extends StatefulWidget {
  @override
  _StudwarsLeaderboardState createState() => _StudwarsLeaderboardState();
}

class _StudwarsLeaderboardState extends State<StudwarsLeaderboard> {
  int _rank = 1;

  static const mapelGrade = <String>[
    'Matematika',
    'Fisika',
    'Kimia',
    'Biologi'
  ];
  String _btnMapelSelected = "Matematika";

  static const listSekolah = <String>[
    'SMAN 1 Semarang',
    'MAS Darul Mursyid',
    'SMAN 1 Jakarta'
  ];
  String _btnSekolahSelected = "MAS Darul Mursyid";

  final List<DropdownMenuItem<String>> _dropDownMenuMapel = mapelGrade
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black))))
      .toList();

  final List<DropdownMenuItem<String>> _dropDownMenuSekolah = listSekolah
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black))))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: DropdownButton(
                        value: _btnMapelSelected,
                        onChanged: (String newValue) {
                          setState(() {
                            _btnMapelSelected = newValue;
                          });
                        },
                        items: this._dropDownMenuMapel,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: DropdownButton(
                        value: _btnSekolahSelected,
                        onChanged: (String newValue) {
                          setState(() {
                            _btnSekolahSelected = newValue;
                          });
                        },
                        items: this._dropDownMenuSekolah,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(children: <Widget>[
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
              ListItemLeaderboard(
                nama: 'Ramadhan Pratama',
                image:
                    'https://miro.medium.com/fit/c/256/256/0*gNqNTTygD0yNHfdD.',
                menang: 32432,
                kalah: 343,
                rank: _rank++,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
