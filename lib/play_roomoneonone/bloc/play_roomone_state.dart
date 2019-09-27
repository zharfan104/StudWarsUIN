import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayRoomoneState extends Equatable {
  PlayRoomoneState([List props = const <dynamic>[]]) : super(props);
}

class InitialPlayRoomoneState extends PlayRoomoneState {}
