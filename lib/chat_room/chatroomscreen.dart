import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chat_room/bloc/chatroom_bloc.dart';
import 'package:flutter_firebase_login/chat_room/chat_room.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:flutter_firebase_login/login/login.dart';

class ChatroomScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String _email;
  ChatroomScreen(
      {Key key,
      @required UserRepository userRepository,
      @required String email})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _email = email,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print(_email);
    return Scaffold(
      body: BlocProvider<ChatroomBloc>(
        builder: (context) => ChatroomBloc(userRepository: _userRepository),
        child: ChatRoom(userRepository: _userRepository),
      ),
    );
  }
}
