import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/list_item_type/list_item_badges.dart';
import 'package:flutter_firebase_login/profile/bloc/bloc.dart';
import 'package:flutter_firebase_login/user.dart';
import 'package:flutter_firebase_login/user_repository.dart';

class ProfilePage extends StatefulWidget {
  final UserRepository _userRepository;

  ProfilePage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfilePage> {
  ProfileBloc _profileBloc;
  UserRepository get _userRepository => widget._userRepository;
  @override
  void initState() {
    super.initState();

    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.dispatch(GetUserRepo());
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Container(
        color: Colors.grey,
        child: ListView(
          children: <Widget>[
            AppBar(
              title: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: "MonsterratBold", color: Colors.white),
                ),
              ),
              backgroundColor: Colors.brown[600],
              centerTitle: true,
            ),
            Divider(),
            KaruIdentitas(
              user: state.user,
            ),
            Center(
              child: Container(
                child: Text('Your Badges',
                    style: TextStyle(
                        color: Colors.brown[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: "MonsterratBold")),
              ),
            ),
            // RaisedButton(
            //   child: Text("data"),
            //   onPressed: () {
            //     _profileBloc.dispatch(GetUserRepo());
            //     print(state.user.picurl);
            //   },
            // ),
            Divider(),
            ListItemBadges(
              nama: 'First Login',
              keterangan: 'This is your first badges. \nCongratulation!',
              image:
                  'https://cdn0.iconfinder.com/data/icons/gamification-flat-awards-and-badges/500/star2-512.png',
            ),
          ],
        ),
      );
    });
  }
}

class KaruIdentitas extends StatelessWidget {
  final User user;
  const KaruIdentitas({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('user')
            .document(user.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            var userDocument = snapshot.data;

            String nama = userDocument["nama"];
            var menang = userDocument["menang"];
            var kalah = userDocument["kalah"];
            var sekolah = userDocument["Sekolah"];
            var level = userDocument["level"];

            return Card(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: new Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(user.picurl)))),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(cekNama(nama) ?? "Loading.....",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        Text(
                          (sekolah == "")
                              ? "Change School On setting"
                              : sekolah,
                          style: TextStyle(fontFamily: "MonsterratBold"),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Win : $menang',
                              style: TextStyle(fontFamily: "MonsterratBold"),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Lost : $kalah',
                              style: TextStyle(fontFamily: "MonsterratBold"),
                            ),
                          ],
                        ),
                        Text(
                          'Level : $level',
                          style: TextStyle(fontFamily: "MonsterratBold"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        });
  }

  String cekNama(String nama) {
    if (nama.length >= 10) {
      return nama.substring(0, 10);
    } else {
      return nama;
    }
  }
}
