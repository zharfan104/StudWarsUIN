import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class GameroomBloc extends Bloc<GameroomEvent, GameroomState> {
  @override
  GameroomState get initialState => InitialGameroomState();

  @override
  Stream<GameroomState> mapEventToState(
    GameroomEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
