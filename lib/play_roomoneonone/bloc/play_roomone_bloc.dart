import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class PlayRoomoneBloc extends Bloc<PlayRoomoneEvent, PlayRoomoneState> {
  UserRepository _userRepository;

  PlayRoomoneBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  PlayRoomoneState get initialState => InitialPlayRoomoneState();

  @override
  Stream<PlayRoomoneState> mapEventToState(
    PlayRoomoneEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
