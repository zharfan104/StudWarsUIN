import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  @override
  LeaderboardState get initialState => InitialLeaderboardState();

  @override
  Stream<LeaderboardState> mapEventToState(
    LeaderboardEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
