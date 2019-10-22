import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/find_room/find_roomscreen.dart';
import 'package:flutter_firebase_login/friends/friends_list_page.dart';
import 'package:flutter_firebase_login/leaderboards/leaderboards_screen.dart';
import 'package:flutter_firebase_login/profile/profilescreen.dart';
import 'package:flutter_firebase_login/settings/setting.dart';
import 'package:flutter_firebase_login/studwars_home.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'oval-right-clipper.dart';

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
  int _currentIndex;

  List<Widget> _tabListView = [];
  PageController _pageController;

  UserRepository get _userRepository => widget._userRepository;
  GlobalKey bottomNavigationKey = GlobalKey();
  Color active = Colors.white;
  @override
  void initState() {
    _currentIndex = 0;
    _tabListView.add(StudwarsHome(
      userRepository: _userRepository,
    ));
    _tabListView.add(FindRoomScreen(
      userRepository: _userRepository,
    ));
    _tabListView.add(LeaderboardScreen());
    _tabListView.add(FriendsListPage());

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
    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure..?'),
              content: new Text('Do you want to exit the room?  '),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: _buildDrawer(),
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
          circleColor: Color(0xFF4c4c4c),
          inactiveIconColor: Color(0xffcfcfcf),
          key: bottomNavigationKey,
          tabs: [
            TabData(iconData: FontAwesomeIcons.plusSquare, title: "New"),
            TabData(iconData: FontAwesomeIcons.search, title: "Find"),
            TabData(iconData: FontAwesomeIcons.list, title: "Board"),
            TabData(iconData: Icons.chat, title: "Chat")
          ],
          onTabChangedListener: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            });
          },
        ),
      ),
    );
  }

  Widget _builderAppBar(String title) {
    return AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(
              Icons.menu,
              color: Color(0xFF4c4c4c),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(0xFF4c4c4c),
            ),
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
                color: Color(0xFF4c4c4c), fontFamily: "tondo", fontSize: 30.0),
            textAlign: TextAlign.center,
          ),
        ));
  }

  _buildDrawer() {
    // final String image = images[0];
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: Color(0xffcfcfcf),
              boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepPurple])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(
                          'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "erika costell",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    "@erika07",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home"),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "Your profile"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "Help"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: active,
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }
}
