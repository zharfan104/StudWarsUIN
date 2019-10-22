import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/find_room/bloc/bloc.dart';
import 'package:flutter_firebase_login/find_room/find_room.dart';
import 'package:flutter_firebase_login/user_repository.dart';

class FindRoomScreen extends StatelessWidget {
  final UserRepository _userRepository;

  FindRoomScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FindRoomBloc>(
      // builder: (context) => FindRoomBloc(userRepository: _userRepository),
      builder: (context) => FindRoomBloc(),

      child: FindRoom(
        userRepository: _userRepository,
      ),
    );
  }
}
