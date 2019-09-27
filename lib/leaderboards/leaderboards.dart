import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/studwars/list_item_type/list_item_leaderboard.dart';
import 'package:flutter_firebase_login/studwars/list_item_type/list_item_search.dart';
import 'package:sliver_glue/sliver_glue.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Center(
            child: Text(
              'Leaderboard',
              style: TextStyle(
                  fontFamily: "MonsterratBold", color: Colors.brown[700]),
            ),
          ),
          backgroundColor: Colors.brown[100],
          expandedHeight: 8.0,
          centerTitle: true,
          pinned: true,
        ),
        SliverGlueFixedList(
          widgets: <Widget>[
            Divider(),
            RefreshIndicator(
              onRefresh: _handleRefresh,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('user')
                    .orderBy("poin")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.brown,
                          ),
                        ),
                      );
                    default:
                      print(snapshot.data.documents[0]["nama"]);
                      var data = snapshot.data.documents;

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return ListItemLeaderboard(
                            image: data[index]["picurl"],
                            kalah: data[index]["kalah"] ?? 0,
                            menang: data[index]["menang"] ?? 0,
                            nama: data[index]["nama"],
                            rank: index + 1,
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

Future<Null> _handleRefresh() async {
  await new Future.delayed(new Duration(seconds: 2));
  return null;
}
