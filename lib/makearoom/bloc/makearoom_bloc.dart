import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_login/UpdateFirebaseRoom.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class MakeARoomBloc extends Bloc<MakeARoomEvent, MakeARoomState> {
  // UserRepository _userRepository;

  // MakeARoomBloc({
  //   @required UserRepository userRepository,
  // })  : assert(userRepository != null),
  //       _userRepository = userRepository;
  @override
  MakeARoomState get initialState => MakeARoomState.empty();

  @override
  Stream<MakeARoomState> mapEventToState(
    MakeARoomEvent event,
  ) async* {
    if (event is BuatRoomPressed) {
      yield* _mapBuatRoomPrssedtoState(
          bab: event.bab,
          mapel: event.mapel,
          tipe: event.tipe,
          namaRoom: event.namaRoom,
          soal: event.soal,
          email: event.email);
    } else if (event is MatpelChanged) {
      yield* _mapMatpeltoState(event.matpel, event.bab);
    } else if (event is BabChanged) {
      yield* _mapBabtoState(event.bab);
    }
  }

  Stream<MakeARoomState> _mapBuatRoomPrssedtoState(
      {String mapel,
      String bab,
      String soal,
      String email,
      @required String namaRoom,
      @required String tipe}) async* {
    try {
      yield currentState.update(isSubmitting: true);

      await UpdateFirebaseRoom.addRoom(
          tipe: tipe,
          namaRoom: namaRoom,
          mapel: mapel,
          soal: soal,
          bab: bab,
          email: email);

      yield currentState.update(
          email: email,
          onPlay: false,
          isSuccess: true,
          isSubmitting: true,
          isGo: true);
    } catch (_) {
      print("SD" + _);
      yield MakeARoomState.failure();
    }
  }

  Stream<MakeARoomState> _mapMatpeltoState(String matpel, String bab) async* {
    yield currentState.update(matpel: matpel, bab: bab, isSuccess: false);
  }

  Stream<MakeARoomState> _mapBabtoState(String bab) async* {
    yield currentState.update(bab: bab, isSuccess: false);
  }
}
