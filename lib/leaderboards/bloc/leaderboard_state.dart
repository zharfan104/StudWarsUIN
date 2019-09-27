import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LeaderboardState extends Equatable {
  LeaderboardState([List props = const <dynamic>[]]) : super(props);
}

class InitialLeaderboardState extends LeaderboardState {}
