import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication_bloc/bloc.dart';
import 'package:flutter_firebase_login/studwars/studwars_leaderboard.dart';
import 'package:flutter_firebase_login/studwars/studwars_profile.dart';
import 'package:flutter_firebase_login/studwars_home.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainMenuAwal extends StatefulWidget {
  final UserRepository _userRepository;

  MainMenuAwal({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _MainMenuAwalState createState() => _MainMenuAwalState();
}

class _MainMenuAwalState extends State<MainMenuAwal> {
  int _currentIndex = 0;

  List<Widget> _tabListView = [];
  List<Widget> _appBarList = [];

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    _tabListView.add(StudwarsHome(
      userRepository: _userRepository,
    ));
    _tabListView.add(StudwarsLeaderboard());
    _tabListView.add(StudwarsProfile());

    _appBarList.add(_builderAppBar("Make A Room"));
    _appBarList.add(_builderAppBarSearch());
    _appBarList.add(_builderAppBar("Leaderboard"));
    _appBarList.add(_builderAppBarProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarList[_currentIndex],
        body: _tabListView[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.greenAccent[900],
          currentIndex: _currentIndex,
          onTap: (currentIndex) {
            setState(() {
              _currentIndex = currentIndex;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.plusSquare),
                title: Text("New Room")),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.list), title: Text("Leaderboard")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("Profile")),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }

  Widget _builderAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.grey.shade800,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(
            LoggedOut(),
          );
        },
      ),
      title: Text(title, style: TextStyle(color: Colors.white70)),
    );
  }

  Widget _builderAppBarSearch() {
    return AppBar(
      backgroundColor: Colors.grey.shade800,
      title: Text("Search", style: TextStyle(color: Colors.white70)),
      actions: <Widget>[Icon(Icons.search)],
    );
  }

  Widget _builderAppBarProfile() {
    return AppBar(
      backgroundColor: Colors.grey.shade800,
      title: Text("Profile", style: TextStyle(color: Colors.white70)),
      actions: <Widget>[Icon(Icons.settings)],
    );
  }
}
