import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatroomEvent extends Equatable {
  ChatroomEvent([List props = const <dynamic>[]]) : super(props);
}

class ExitChat extends ChatroomEvent {
  @override
  String toString() => 'ExitChat {}';
}
