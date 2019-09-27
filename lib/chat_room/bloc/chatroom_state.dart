import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatroomState extends Equatable {
  ChatroomState([List props = const <dynamic>[]]) : super(props);
}

class InitialChatroomState extends ChatroomState {}
