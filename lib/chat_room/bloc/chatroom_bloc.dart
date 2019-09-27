import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import '../../UpdateFirebaseRoom.dart';
import './bloc.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  final UserRepository _userRepository;

  ChatroomBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  ChatroomState get initialState => InitialChatroomState();

  @override
  Stream<ChatroomState> mapEventToState(
    ChatroomEvent event,
  ) async* {
    if (event is ExitChat) {
      await UpdateFirebaseRoom.exitRoom();
    }
  }
}
