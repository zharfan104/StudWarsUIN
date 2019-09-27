import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LeaderboardEvent extends Equatable {
  LeaderboardEvent([List props = const <dynamic>[]]) : super(props);
}
