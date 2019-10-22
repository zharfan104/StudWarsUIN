import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OneEvent extends Equatable {
  OneEvent([List props = const []]) : super(props);
}

class Start extends OneEvent {
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

class Pause extends OneEvent {
  @override
  String toString() => "Pause";
}

class Resume extends OneEvent {
  @override
  String toString() => "Resume";
}

class Reset extends OneEvent {
  @override
  String toString() => "Reset";
}

class Tick extends OneEvent {
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
