import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/play_roomoneonone/bloc/play_roomone_bloc.dart';
import 'package:flutter_firebase_login/play_roomoneonone/play_roomone.dart';
import 'package:flutter_firebase_login/user_repository.dart';

class PlayRoomoneScreen extends StatelessWidget {
  final UserRepository _userRepository;

  PlayRoomoneScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PlayRoomoneBloc>(
        builder: (context) => PlayRoomoneBloc(userRepository: _userRepository),
        child: PlayRoomone(userRepository: _userRepository),
      ),
    );
  }
}
