import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/studwars/list_item_type/type_title.dart';

class ListItemBadges extends StatelessWidget {
  final String nama;
  final String image;
  final String keterangan;

  const ListItemBadges({Key key, this.nama, this.image, this.keterangan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            height: 72.0,
            width: 72.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Image.network(image)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new MenuTitle(title: nama),
                SizedBox(
                  height: 2,
                ),
                Container(
                  child: AutoSizeText(
                    keterangan,
                    maxLines: 10,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      borderOnForeground: true,
    );
  }
}
