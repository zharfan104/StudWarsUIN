import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository _userRepository;

  ProfileBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  ProfileState get initialState => ProfileState.empty();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event == GetUserRepo()) {
      yield* _mapGetUserRepotoState();
    }
  }

  Stream<ProfileState> _mapGetUserRepotoState() async* {
    var x = await _userRepository.getProfile();
    yield ProfileState(user: x);
  }
}
