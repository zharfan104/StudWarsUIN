import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_login/UpdateFirebaseRoom.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class MakeARoomBloc extends Bloc<MakeARoomEvent, MakeARoomState> {
  UserRepository _userRepository;

  MakeARoomBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  MakeARoomState get initialState => MakeARoomState.empty();

  @override
  Stream<MakeARoomState> mapEventToState(
    MakeARoomEvent event,
  ) async* {
    if (event is BuatRoomPressed) {
      yield* _mapBuatRoomPrssedtoState(
          bab: event.bab, mapel: event.mapel, soal: event.soal);
    }
  }

  Stream<MakeARoomState> _mapBuatRoomPrssedtoState(
      {String mapel, String bab, String soal}) async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      yield MakeARoomState.loading();
      await UpdateFirebaseRoom.addRoom(mapel: mapel, soal: soal, bab: bab);

      yield MakeARoomState.updateEmail(email: email, onPlay: false);
    } catch (_) {
      print("SD" + _);
      yield MakeARoomState.failure();
    }
  }
}
