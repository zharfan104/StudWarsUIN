import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication_bloc/bloc.dart';
import 'package:flutter_firebase_login/find_room/find_roomscreen.dart';
import 'package:flutter_firebase_login/leaderboards/leaderboards_screen.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/profile/profilescreen.dart';
import 'package:flutter_firebase_login/settings/setting.dart';
import 'package:flutter_firebase_login/studwars/studwars_home.dart';
import 'package:flutter_firebase_login/studwars/studwars_leaderboard.dart';
import 'package:flutter_firebase_login/studwars/studwars_profile.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainMenu extends StatefulWidget {
  final UserRepository _userRepository;

  MainMenu({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentIndex = 0;

  List<Widget> _tabListView = [];
  PageController _pageController;

  UserRepository get _userRepository => widget._userRepository;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    _tabListView.add(StudwarsHome(
      userRepository: _userRepository,
    ));
    _tabListView.add(FindRoomScreen(
      userRepository: _userRepository,
    ));
    _tabListView.add(LeaderboardScreen());
    _tabListView.add(ProfileScreen(
      userRepository: _userRepository,
    ));

    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builderAppBar("StudWars"),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            print(index.toString());
            final FancyBottomNavigationState fState =
                bottomNavigationKey.currentState;
            fState.setPage(index);
          });
        },
        controller: _pageController,
        children: <Widget>[
          _tabListView[0],
          _tabListView[1],
          _tabListView[2],
          _tabListView[3],
        ],
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.brown[300],
        inactiveIconColor: Colors.grey,
        key: bottomNavigationKey,
        tabs: [
          TabData(iconData: FontAwesomeIcons.plusSquare, title: "New"),
          TabData(iconData: FontAwesomeIcons.search, title: "Find"),
          TabData(iconData: FontAwesomeIcons.list, title: "Board"),
          TabData(iconData: Icons.account_circle, title: "Profile")
        ],
        onTabChangedListener: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
      ),
    );
  }

  Widget _builderAppBar(String title) {
    return AppBar(
        backgroundColor: Colors.grey.shade800,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // BlocProvider.of<AuthenticationBloc>(context).dispatch(
              //   LoggedOut(),
              // );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Setting(userRepository: _userRepository)));
            },
          ),
        ],
        title: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white70,
                fontFamily: "MonsterratBold",
                fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
