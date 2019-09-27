import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class OneonOneRoom extends StatefulWidget {
  OneonOneRoom({Key key}) : super(key: key);

  @override
  _OneonOneRoomState createState() => _OneonOneRoomState();
}

class _OneonOneRoomState extends State<OneonOneRoom> {
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Scaffold(
      body: Container(
        color: Colors.yellow.withAlpha(64),
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            
            RaisedButton(
              onPressed: () {},
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
