import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../UpdateFirebaseRoom.dart';
import './bloc.dart';

class ChatroomBloc3 extends Bloc<ChatroomEvent3, ChatroomState3> {
  // final UserRepository _userRepository;
  // final String _namaRoom;
  // final String _roomEmail;

  // ChatroomBloc3(
  //     {@required UserRepository userRepository,
  //     @required String namaRoom,
  //     @required String roomEmail})
  //     : assert(userRepository != null),
  //       _namaRoom = namaRoom,
  //       _roomEmail = roomEmail;

  @override
  ChatroomState3 get initialState => ChatroomState3.empty();

  @override
  Stream<ChatroomState3> mapEventToState(
    ChatroomEvent3 event,
  ) async* {
    if (event is ExitChat) {
      await UpdateFirebaseRoom.exitRoom();
    } else if (event is RoomFull) {
      yield currentState.update(isFull: true);
    } else if (event is RoomNotFull) {
      yield currentState.update(isFull: false);
    } else if (event is ReadyClicked) {
      yield* _mapReadyClickedToState(
          event.tipe, event.roomEmail, event.namaRoom, event.email);
    } else if (event is CancelClicked) {
      yield* _mapCancelClickedToState(
          event.tipe, event.roomEmail, event.namaRoom, event.email);
    } else if (event is PlayOneOnOne) {
      yield* _mapPlayOneOnOneToState(
          event.tipe, event.roomEmail, event.namaRoom, event.email);
    }
  }

  Stream<ChatroomState3> _mapReadyClickedToState(
      String tipe, String roomEmail, String namaRoom, String email) async* {
    email = email.replaceAll(".", "");
    await UpdateFirebaseRoom.imReady(
        email: email, roomEmail: roomEmail, namaRoom: namaRoom, tipe: tipe);
    yield currentState.update(isReady: true);
  }

  Stream<ChatroomState3> _mapPlayOneOnOneToState(
      String tipe, String roomEmail, String namaRoom, String email) async* {
    email = email.replaceAll(".", "");
    await UpdateFirebaseRoom.imPlay(
        email: email, roomEmail: roomEmail, namaRoom: namaRoom, tipe: tipe);
    yield currentState.update(isPlay: true);
  }

  Stream<ChatroomState3> _mapCancelClickedToState(
      String tipe, String roomEmail, String namaRoom, String email) async* {
    email = email.replaceAll(".", "");
    await UpdateFirebaseRoom.imNotReady(
        email: email, roomEmail: roomEmail, namaRoom: namaRoom, tipe: tipe);
    yield currentState.update(isReady: false);
  }
}
