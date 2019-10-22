import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const <dynamic>[]]) : super(props);
}

class GetUserRepo extends ProfileEvent {
  @override
  String toString() => 'GetUserRepo';
}
