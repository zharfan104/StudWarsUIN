import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/studwars/list_item_type/type_title.dart';

class ListItemMenu extends StatelessWidget {
  final String title;
  final String image;

  const ListItemMenu({Key key, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: ListTile(
        leading: Container(
          child: Image.asset(image),
        ),
        title: Container(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[new MenuTitle(title: title)],
          ),
        ),
      ),
      borderOnForeground: true,
    );
  }
}
