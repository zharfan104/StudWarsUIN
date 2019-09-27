import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  final String title;

  const MenuTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      minFontSize: 14,
    );
  }
}
