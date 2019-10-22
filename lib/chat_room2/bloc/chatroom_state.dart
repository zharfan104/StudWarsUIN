import 'package:meta/meta.dart';

@immutable
class ChatroomState2 {
  final bool isReady;
  final bool isPeerReady;
  final bool isPlay;
  final bool isFull;
  final int user;
  ChatroomState2({
    @required this.isReady,
    @required this.isPeerReady,
    @required this.isPlay,
    @required this.isFull,
    @required this.user,
  });

  factory ChatroomState2.empty() {
    return ChatroomState2(
        isReady: false,
        isPeerReady: false,
        isPlay: false,
        isFull: false,
        user: 1);
  }
  factory ChatroomState2.full() {
    return ChatroomState2(
        isReady: false,
        isPeerReady: false,
        isPlay: false,
        isFull: true,
        user: 1);
  }
  ChatroomState2 update(
      {int user, bool isReady, bool isPlay, bool isPeerReady, bool isFull}) {
    return copyWith(
        isReady: isReady,
        isPeerReady: isPeerReady,
        isPlay: isPlay,
        user: user,
        isFull: isFull);
  }

  ChatroomState2 copyWith(
      {bool isReady, bool isPeerReady, bool isPlay, bool isFull, int user}) {
    return ChatroomState2(
        isReady: isReady ?? this.isReady,
        isPeerReady: isPeerReady ?? this.isPeerReady,
        isPlay: isPlay ?? this.isPlay,
        isFull: isFull ?? this.isFull,
        user: user ?? this.user);
  }

  @override
  String toString() {
    return '''ChatroomState2 {
     
      isFull: $isFull,
 
    }''';
  }
}
