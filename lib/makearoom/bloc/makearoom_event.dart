import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MakeARoomEvent extends Equatable {
  MakeARoomEvent([List props = const <dynamic>[]]) : super(props);
}

class BuatRoomPressed extends MakeARoomEvent {
  final String bab;
  final String soal;
  final String mapel;

  BuatRoomPressed(
      {@required this.bab, @required this.soal, @required this.mapel});
  @override
  String toString() =>
      'BuatRoomPressed {bab: $bab, soal : $soal, mapel: $mapel}';
}
