import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class OneononegameBloc extends Bloc<OneononegameEvent, OneononegameState> {
  @override
  OneononegameState get initialState => InitialOneononegameState();

  @override
  Stream<OneononegameState> mapEventToState(
    OneononegameEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
