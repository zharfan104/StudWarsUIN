import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_firebase_login/oneonone/question_model.dart';

class KunciJawaban extends StatelessWidget {
  final List<QuestionModel> pertanyaan;
  final Map<int, dynamic> jawaban;

  const KunciJawaban(
      {Key key, @required this.pertanyaan, @required this.jawaban})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade700,
        leading: Icon(Icons.info, color: Colors.white),
        title: Text('Answer Key',
            style:
                TextStyle(color: Colors.white, fontFamily: "MonsterratBold")),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(color: Colors.blueAccent.shade700),
              height: 200,
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: pertanyaan.length + 1,
            itemBuilder: _buildItem,
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == pertanyaan.length) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: RaisedButton(
          child: Text("back",
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
    QuestionModel soal = pertanyaan[index];
    bool correct = soal.jwbBenar == jawaban[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              soal.pertanyaan,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            correct
                ? Container()
                : Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "Answer: "),
                      TextSpan(
                          text: soal.jwbBenar,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "MonsterratBold"))
                    ]),
                    style:
                        TextStyle(fontSize: 16.0, fontFamily: "MonsterratBold"),
                  )
          ],
        ),
      ),
    );
  }
}
