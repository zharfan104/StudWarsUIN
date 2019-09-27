import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayRoomoneEvent extends Equatable {
  PlayRoomoneEvent([List props = const <dynamic>[]]) : super(props);
}
