import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class MakeARoomState {
  final bool isGo;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  final bool onPlay;
  final String nama_room;
  final String email;
  final String soal;
  final String matpel;
  final String bab;
  MakeARoomState(
      {@required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      @required this.isGo,
      this.nama_room,
      this.email,
      this.onPlay,
      this.soal,
      this.matpel,
      this.bab});
  factory MakeARoomState.empty() {
    return MakeARoomState(
        nama_room: "Aselole",
        isSubmitting: false,
        isGo: false,
        isSuccess: false,
        isFailure: false,
        onPlay: false,
        email: "zharfan.akbar104@gmail.com",
        matpel: "Matematika",
        bab: "Aljabar");
  }

  factory MakeARoomState.failure() {
    return MakeARoomState(
      isGo: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      onPlay: false,
    );
  }

  factory MakeARoomState.success() {
    return MakeARoomState(
      isGo: false,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      onPlay: true,
    );
  }

  MakeARoomState update(
      {String email,
      String bab,
      String matpel,
      String nama_room,
      String soal,
      bool isGo,
      bool isSubmitting,
      bool isSuccess,
      bool onPlay}) {
    return copyWith(
        email: email,
        nama_room: nama_room,
        onPlay: onPlay,
        isGo: isGo,
        isSubmitting: isSubmitting,
        isSuccess: isSuccess,
        isFailure: false,
        bab: bab,
        soal: soal,
        matpel: matpel);
  }

  MakeARoomState copyWith(
      {String email,
      bool onPlay,
      bool isSubmitting,
      bool isGo,
      bool isSuccess,
      bool isFailure,
      String nama_room,
      String bab,
      String matpel,
      String soal}) {
    return MakeARoomState(
        nama_room: nama_room ?? this.nama_room,
        isGo: isGo ?? this.isGo,
        email: email ?? this.email,
        onPlay: onPlay ?? this.onPlay,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        bab: bab ?? this.bab,
        soal: soal ?? this.soal,
        matpel: matpel ?? this.matpel);
  }
}
