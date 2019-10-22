import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatroomEvent3 extends Equatable {
  ChatroomEvent3([List props = const <dynamic>[]]) : super(props);
}

class ExitChat extends ChatroomEvent3 {
  @override
  String toString() => 'ExitChat {}';
}

class ReadyClicked extends ChatroomEvent3 {
  final String namaRoom;
  final String roomEmail;
  final String tipe;
  final String email;

  ReadyClicked(
      {@required this.email,
      @required this.namaRoom,
      @required this.roomEmail,
      @required this.tipe});
  @override
  String toString() => 'ReadyClicked {}';
}

class PlayOneOnOne extends ChatroomEvent3 {
  final String namaRoom;
  final String roomEmail;
  final String tipe;
  final String email;
  PlayOneOnOne(
      {@required this.email,
      @required this.namaRoom,
      @required this.roomEmail,
      @required this.tipe});
  @override
  String toString() => 'PlayOneOnOne {}';
}

class PeerReady extends ChatroomEvent3 {
  @override
  String toString() => 'PeerReady {}';
}

class RoomFull extends ChatroomEvent3 {
  @override
  String toString() => 'RoomFull {}';
}

class RoomNotFull extends ChatroomEvent3 {
  @override
  String toString() => 'RoomNotFull {}';
}

class CancelClicked extends ChatroomEvent3 {
  final String namaRoom;
  final String roomEmail;
  final String tipe;
  final String email;
  CancelClicked(
      {@required this.email,
      @required this.namaRoom,
      @required this.roomEmail,
      @required this.tipe});
  @override
  String toString() => 'RoomFull {}';
}
