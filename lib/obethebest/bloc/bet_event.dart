import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BeTEvent extends Equatable {
  BeTEvent([List props = const []]) : super(props);
}

class Start extends BeTEvent {
  final int duration;
  final int idxsoal;
  final int lokal;

  final bool isDone;

  Start(
      {@required this.duration,
      @required this.isDone,
      @required this.idxsoal,
      @required this.lokal})
      : super([duration, isDone, idxsoal]);

  @override
  String toString() => "Start { duration: $duration }";
}

class Pause extends BeTEvent {
  @override
  String toString() => "Pause";
}

class Resume extends BeTEvent {
  @override
  String toString() => "Resume";
}

class Reset extends BeTEvent {
  @override
  String toString() => "Reset";
}

class Tick extends BeTEvent {
  final int duration;
  final int idxsoal;
  final bool isDone;
  final int lokal;

  Tick(
      {@required this.duration,
      @required this.idxsoal,
      @required this.isDone,
      @required this.lokal})
      : super([duration, idxsoal]);

  @override
  String toString() =>
      "Tick { duration: $duration , idxsoal : $idxsoal, lokal: $lokal, isDone : $isDone}";
}
