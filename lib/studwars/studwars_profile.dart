import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/studwars/list_item_type/list_item_badges.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'charttest.dart';

class StudwarsProfile extends StatefulWidget {
  final UserRepository _userRepository;

  StudwarsProfile({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<StudwarsProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 100, width: 100, child: ChartMenangKalah()),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Ramadhan Pratama',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        Text('MAS Darul Mursyid'),
                        Row(
                          children: <Widget>[
                            Text('Menang : 1000'),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text('Kalah : 500'),
                          ],
                        ),
                        Text('Level : 12'),
                        Text('Point : 3432')
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text('Badges',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Divider(),
            ListItemBadges(
              nama: 'Master of Chemist',
              keterangan: 'kamu mastah kimia bro',
              image:
                  'https://materikimia.com/wp-content/uploads/2018/03/Persamaan-Reaksi-Kimia.png',
            ),
            ListItemBadges(
              nama: 'Master of Chemist',
              keterangan: 'kamu mastah kimia bro',
              image:
                  'https://materikimia.com/wp-content/uploads/2018/03/Persamaan-Reaksi-Kimia.png',
            ),
            ListItemBadges(
              nama: 'Master of Chemist',
              keterangan: 'kamu mastah kimia bro',
              image:
                  'https://materikimia.com/wp-content/uploads/2018/03/Persamaan-Reaksi-Kimia.png',
            ),
            ListItemBadges(
              nama: 'Master of Chemist',
              keterangan: 'kamu mastah kimia bro',
              image:
                  'https://materikimia.com/wp-content/uploads/2018/03/Persamaan-Reaksi-Kimia.png',
            ),
            ListItemBadges(
              nama: 'Master of Chemist',
              keterangan: 'kamu mastah kimia bro',
              image:
                  'https://materikimia.com/wp-content/uploads/2018/03/Persamaan-Reaksi-Kimia.png',
            ),
            ListItemBadges(
              nama: 'Master of Chemist',
              keterangan: 'kamu mastah kimia bro',
              image:
                  'https://materikimia.com/wp-content/uploads/2018/03/Persamaan-Reaksi-Kimia.png',
            ),
          ],
        ),
      ),
    );
  }
}
