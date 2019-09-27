import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Test1",
    home: Fk(),
  ));
}

class Fk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fakultas Kedokteran'),
      ),
      body: Column(
        children: <Widget>[
          Center(
              child:
                  Image.network('https://images.app.goo.gl/7SBqmbvmmRwqtLPf6')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Card(
                          child: Text('FK'),
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Fakultas Kedokteran Universitas Diponegoro merupakan salah satu fakultas kedokteran terdepan di Indonesia. Fakultas Kedokteran Universitas Diponegoro didirikan pada 1 Oktober 1961, dan pada tahun 2011 merayakan 50 tahun keeemasannya dalam memberikan tri dharma perguruan tinggi di Indonesia ",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Ft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fakultas Kedokteran'),
      ),
      body: Column(
        children: <Widget>[
          Center(
              child:
                  Image.network('https://images.app.goo.gl/oEgtv2xyEb2CFcWE6')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Card(
                          child: Text('FK'),
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Fakultas Teknik Universitas Universitas Diponegoro disingkat FT UNDIP adalah salah satu fakultas di bawah Universitas Diponegoro yang saat ini dipimpin oleh Dekan Ir. M. Agung Wibowo, MM, MSc, PhD.. Fakultas Teknik didirikan pada 15 Oktober 1960.",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
