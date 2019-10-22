import 'package:meta/meta.dart';

@immutable
class MakeARoomState2 {
  final bool isGo;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  final bool onPlay;
  final String namaRoom;
  final String email;
  final String soal;
  final String matpel;
  final String bab;
  MakeARoomState2(
      {@required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      @required this.isGo,
      this.namaRoom,
      this.email,
      this.onPlay,
      this.soal,
      this.matpel,
      this.bab});
  factory MakeARoomState2.empty() {
    return MakeARoomState2(
        namaRoom: "Aselole",
        isSubmitting: false,
        isGo: false,
        isSuccess: false,
        isFailure: false,
        onPlay: false,
        email: "zharfan.akbar104@gmail.com",
        matpel: "Matematika",
        bab: "Aljabar");
  }

  factory MakeARoomState2.failure() {
    return MakeARoomState2(
      isGo: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      onPlay: false,
    );
  }

  factory MakeARoomState2.success() {
    return MakeARoomState2(
      isGo: false,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      onPlay: true,
    );
  }

  MakeARoomState2 update(
      {String email,
      String bab,
      String matpel,
      String namaRoom,
      String soal,
      bool isGo,
      bool isSubmitting,
      bool isSuccess,
      bool onPlay}) {
    return copyWith(
        email: email,
        namaRoom: namaRoom,
        onPlay: onPlay,
        isGo: isGo,
        isSubmitting: isSubmitting,
        isSuccess: isSuccess,
        isFailure: false,
        bab: bab,
        soal: soal,
        matpel: matpel);
  }

  MakeARoomState2 copyWith(
      {String email,
      bool onPlay,
      bool isSubmitting,
      bool isGo,
      bool isSuccess,
      bool isFailure,
      String namaRoom,
      String bab,
      String matpel,
      String soal}) {
    return MakeARoomState2(
        namaRoom: namaRoom ?? this.namaRoom,
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
