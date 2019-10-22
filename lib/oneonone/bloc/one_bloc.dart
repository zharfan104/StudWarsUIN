import 'dart:async';

import 'package:flutter_firebase_login/oneonone/ticker.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class OneBloc extends Bloc<OneEvent, OneState> {
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubscription;

  OneBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  OneState get initialState => Ready(_duration, false, 0, 0);

  @override
  void onTransition(Transition<OneEvent, OneState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<OneState> mapEventToState(
    OneEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Pause) {
      yield* _mapPauseToState(event);
    } else if (event is Resume) {
      yield* _mapResumeToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }

  Stream<OneState> _mapStartToState(Start start) async* {
    yield Running(start.duration, start.isDone, start.idxsoal, start.lokal);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: start.duration).listen(
      (duration) {
        dispatch(Tick(
            duration: duration,
            idxsoal: start.idxsoal,
            isDone: start.isDone,
            lokal: start.lokal));
      },
    );
  }

  Stream<OneState> _mapPauseToState(Pause pause) async* {
    final state = currentState;
    if (state is Running) {
      _tickerSubscription?.pause();
      yield Paused(state.duration, false, 0, 0);
    }
  }

  Stream<OneState> _mapResumeToState(Resume resume) async* {
    final state = currentState;
    if (state is Paused) {
      _tickerSubscription?.resume();
      yield Running(state.duration, false, 0, 0);
    }
  }

  Stream<OneState> _mapResetToState(Reset reset) async* {
    _tickerSubscription?.cancel();
    yield Ready(_duration, false, 0, 0);
  }

  Stream<OneState> _mapTickToState(Tick tick) async* {
    if (tick.duration >= 0) {
      yield Running(tick.duration, tick.isDone, tick.idxsoal, tick.lokal);
    } else {
      Finished(tick.idxsoal, tick.lokal);
    }
  }
}
