import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameroomEvent extends Equatable {
  GameroomEvent([List props = const <dynamic>[]]) : super(props);
}
