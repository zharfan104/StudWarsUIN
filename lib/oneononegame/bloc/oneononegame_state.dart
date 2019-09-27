import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OneononegameState extends Equatable {
  OneononegameState([List props = const <dynamic>[]]) : super(props);
}

class InitialOneononegameState extends OneononegameState {}
