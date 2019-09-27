import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameroomState extends Equatable {
  GameroomState([List props = const <dynamic>[]]) : super(props);
}

class InitialGameroomState extends GameroomState {}
