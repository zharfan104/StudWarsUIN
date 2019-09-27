import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_firebase_login/find_room/bloc/find_room_event.dart';
import './bloc.dart';

class FindRoomBloc extends Bloc<FindRoomEvent, FindRoomState> {
  UserRepository _userRepository;

  FindRoomBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  FindRoomState get initialState => FindRoomState.empty();

  @override
  Stream<FindRoomState> transformEvents(
    Stream<FindRoomEvent> events,
    Stream<FindRoomState> Function(FindRoomEvent event) next,
  ) {
    final observableStream = events as Observable<FindRoomEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! BabChanged && event is! SoalChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is BabChanged || event is SoalChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<FindRoomState> mapEventToState(
    FindRoomEvent event,
  ) async* {
    if (event is SearchPressed) {
      yield* _mapSearchtoState(
          bab: event.bab,
          matpel: event.matpel,
          br: event.br,
          soal: event.soal,
          obo: event.obo,
          btb: event.btb);
    } else if (event is MatpelChanged) {
      yield* _mapMatpeltoState(event.matpel, event.bab);
    } else if (event is BabChanged) {
      yield* _mapBabtoState(event.bab);
    } else if (event is SoalChanged) {
      yield* _mapSoaltoState(event.soal);
    } else if (event is OboChanged) {
      yield* _mapObotoState(event.obo);
    } else if (event is BtbChanged) {
      yield* _mapBtbtoState(event.btb);
    } else if (event is BrChanged) {
      yield* _mapBrtoState(event.br);
    }
  }

  Stream<FindRoomState> _mapSearchtoState(
      {String bab,
      String matpel,
      String soal,
      bool btb,
      bool obo,
      bool br}) async* {
    yield FindRoomState(
        bab: bab, soal: soal, matpel: matpel, br: br, btb: btb, obo: obo);
  }

  Stream<FindRoomState> _mapMatpeltoState(String matpel, String bab) async* {
    yield currentState.update(matpel: matpel, bab: bab);
  }

  Stream<FindRoomState> _mapBabtoState(String bab) async* {
    yield currentState.update(bab: bab);
  }

  Stream<FindRoomState> _mapSoaltoState(String soal) async* {
    yield currentState.update(soal: soal);
  }

  Stream<FindRoomState> _mapObotoState(bool obo) async* {
    yield currentState.update(obo: obo);
  }

  Stream<FindRoomState> _mapBtbtoState(bool btb) async* {
    yield currentState.update(btb: btb);
  }

  Stream<FindRoomState> _mapBrtoState(bool br) async* {
    yield currentState.update(br: br);
  }
}
