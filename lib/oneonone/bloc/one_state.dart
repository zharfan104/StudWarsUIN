import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OneState extends Equatable {
  final int duration;
  final bool isDone;
  final int idxsoal;
  final int lokal;

  OneState(this.duration, this.isDone, this.idxsoal, this.lokal,
      [List props = const []])
      : super([duration, isDone, idxsoal, lokal]..addAll(props));
}

class Ready extends OneState {
  Ready(int duration, bool isDone, int idxsoal, int lokal)
      : super(duration, isDone, idxsoal, lokal);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class Paused extends OneState {
  Paused(int duration, bool isDone, int idxsoal, int lokal)
      : super(duration, isDone, idxsoal, lokal);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Running extends OneState {
  Running(int duration, bool isDone, int idxsoal, int lokal)
      : super(duration, isDone, idxsoal, lokal);

  @override
  String toString() => 'Running { duration: $duration }';
}

class Finished extends OneState {
  Finished(int idxsoal, int lokal) : super(0, true, idxsoal, lokal);

  @override
  String toString() => 'Finished';
}
