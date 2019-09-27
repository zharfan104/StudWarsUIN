import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FindRoomEvent extends Equatable {
  FindRoomEvent([List props = const <dynamic>[]]) : super(props);
}

class SearchPressed extends FindRoomEvent {
  final String bab;
  final String matpel;
  final String soal;
  final bool btb;
  final bool obo;
  final bool br;

  SearchPressed(
      {this.bab, this.matpel, this.soal, this.btb, this.obo, this.br});
  @override
  String toString() =>
      'SearchPressed {bab : $bab, matpel:$matpel,soal :$soal, btb:$btb, obo:$obo, br:$br  }';
}

class MatpelChanged extends FindRoomEvent {
  final String matpel;

  final String bab;
  MatpelChanged({this.matpel, this.bab});
  @override
  String toString() => 'MatpeChanged {matpel: $matpel, bab:$bab}';
}

class BabChanged extends FindRoomEvent {
  final String bab;

  BabChanged({this.bab});
  @override
  String toString() => 'Bab : $bab';
}

class SoalChanged extends FindRoomEvent {
  final String soal;

  SoalChanged({this.soal});
  @override
  String toString() => 'SoalChanged : $soal';
}

class OboChanged extends FindRoomEvent {
  final bool obo;

  OboChanged({this.obo});
  @override
  String toString() => 'OboChanged : $obo';
}

class BtbChanged extends FindRoomEvent {
  final bool btb;

  BtbChanged({this.btb});
  @override
  String toString() => 'BtbChanged : $btb';
}

class BrChanged extends FindRoomEvent {
  final bool br;

  BrChanged({this.br});
  @override
  String toString() => 'BrChanged : $br';
}
