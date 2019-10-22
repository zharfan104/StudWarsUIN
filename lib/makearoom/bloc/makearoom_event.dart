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
  final String email;
  final String namaRoom;
  final String tipe;
  BuatRoomPressed(
      {@required this.bab,
      @required this.soal,
      @required this.namaRoom,
      @required this.tipe,
      @required this.mapel,
      @required this.email});
  @override
  String toString() =>
      'BuatRoomPressed {bab: $bab, soal : $soal, mapel: $mapel}';
}

class MatpelChanged extends MakeARoomEvent {
  final String matpel;

  final String bab;
  MatpelChanged({this.matpel, this.bab});
  @override
  String toString() => 'MatpeChanged {matpel: $matpel, bab:$bab}';
}

class BabChanged extends MakeARoomEvent {
  final String bab;

  BabChanged({this.bab});
  @override
  String toString() => 'Bab : $bab';
}
