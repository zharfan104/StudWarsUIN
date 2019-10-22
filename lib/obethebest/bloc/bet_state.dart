import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BeTState extends Equatable {
  final int duration;
  final bool isDone;
  final int idxsoal;
  final int lokal;

  BeTState(this.duration, this.isDone, this.idxsoal, this.lokal,
      [List props = const []])
      : super([duration, isDone, idxsoal, lokal]..addAll(props));
}

class Ready extends BeTState {
  Ready(int duration, bool isDone, int idxsoal, int lokal)
      : super(duration, isDone, idxsoal, lokal);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class Paused extends BeTState {
  Paused(int duration, bool isDone, int idxsoal, int lokal)
      : super(duration, isDone, idxsoal, lokal);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Running extends BeTState {
  Running(int duration, bool isDone, int idxsoal, int lokal)
      : super(duration, isDone, idxsoal, lokal);

  @override
  String toString() => 'Running { duration: $duration }';
}

class Finished extends BeTState {
  Finished(int idxsoal, int lokal) : super(0, true, idxsoal, lokal);

  @override
  String toString() => 'Finished';
}
