import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/login/login_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication_bloc/bloc.dart';
import 'package:flutter_firebase_login/splash_screen.dart';

import 'package:flutter_firebase_login/user_repository.dart';

import 'main_menu.dart';

void main() {
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the app?  '),
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: OneScreen(
      //   email: "zharfan.akbar104@gmail.com",
      //   namaRoom: "sini",
      //   pertanyaan: listModelPertanyaan,
      //   roomEmail: "zharfan.akbar104@gmail.com",
      //   tipe: "One On One",
      //   userRepository: _userRepository,
      // ),
      // BlocProvider(
      //   builder: (context) => OneBloc(ticker: Ticker()),
      //   child: One(
      //     email: "zharfan.akbar104@gmail.com",
      //     namaRoom: "sini",
      //     pertanyaan: listModelPertanyaan,
      //     roomEmail: "zharfan.akbar104@gmail.com",
      //     tipe: "One On One",
      //     userRepository: _userRepository,
      //   ),
      // ),
      // home: BlocProvider(
      //   builder: (context) => PlayRoomoneBloc(ticker: Ticker()),
      //   child: PlayRoomoneScreen(
      //     email: "zharfan.akbar104@gmail.com",
      //     namaRoom: "sini",
      //     roomEmail: "zharfan.akbar104@gmail.com",
      //     tipe: "One On One",
      //     userRepository: _userRepository,
      //     pertanyaan: listModelPertanyaan,
      //   ),
      // ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            // return ChatRoom();
            return WillPopScope(
              onWillPop: _onWillPop,
              child: MainMenu(
                userRepository: _userRepository,
              ),
            );
          }
          return SplashScreen();
        },
      ),
      theme: ThemeData(
          primaryColor: Colors.white,
          canvasColor: Colors.white,
          accentColor: Colors.white,
          fontFamily: "Monsterrat"),
    );
  }
}
