import 'package:meta/meta.dart';

@immutable
class FindRoomState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String matpel;
  final String soal;
  final String bab;
  final bool obo;
  final bool btb;
  final bool br;

  FindRoomState({
    this.isSubmitting,
    this.isSuccess,
    this.isFailure,
    this.matpel,
    this.soal,
    this.bab,
    this.br,
    this.obo,
    this.btb,
  });
  factory FindRoomState.empty() {
    return FindRoomState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        soal: "Semua",
        bab: "Semua",
        matpel: "Semua",
        br: true,
        btb: true,
        obo: true);
  }
  factory FindRoomState.loading() {
    return FindRoomState(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        soal: "Semua",
        bab: "Semua Matpel",
        matpel: "Semua Matpel",
        br: true,
        btb: true,
        obo: true);
  }
  factory FindRoomState.success() {
    return FindRoomState(
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        soal: "Semua",
        bab: "Semua Matpel",
        matpel: "Semua Matpel",
        br: true,
        btb: true,
        obo: true);
  }
  factory FindRoomState.failure() {
    return FindRoomState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        soal: "Semua",
        bab: "Semua Matpel",
        matpel: "Semua Matpel",
        br: true,
        btb: true,
        obo: true);
  }

  FindRoomState copyWith({
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String matpel,
    String soal,
    String bab,
    bool obo,
    bool btb,
    bool br,
  }) {
    return FindRoomState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      matpel: matpel ?? this.matpel,
      soal: soal ?? this.soal,
      obo: obo ?? this.obo,
      btb: btb ?? this.btb,
      br: br ?? this.br,
      bab: bab ?? this.bab,
    );
  }

  FindRoomState update({
    final String matpel,
    final String soal,
    final String bab,
    final bool obo,
    final bool btb,
    final bool br,
  }) {
    return copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        matpel: matpel,
        bab: bab,
        soal: soal,
        obo: obo,
        btb: btb,
        br: br);
  }
}
