import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/profile/bloc/profile_bloc.dart';
import 'package:flutter_firebase_login/profile/profile.dart';
import 'package:flutter_firebase_login/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  final UserRepository _userRepository;

  ProfileScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProfileBloc>(
        builder: (context) => ProfileBloc(userRepository: _userRepository),
        child: ProfilePage(userRepository: _userRepository),
      ),
    );
  }
}
