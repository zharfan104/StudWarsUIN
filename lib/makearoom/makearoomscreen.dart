import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/makearoom/makearoom.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'bloc/bloc.dart';

class MakeARoomScreen extends StatelessWidget {
  UserRepository _userRepository;
  MakeARoomScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: BlocProvider<MakeARoomBloc>(
          builder: (context) => MakeARoomBloc(userRepository: _userRepository),
          child: MakeARoom(
            userRepository: _userRepository,
          ),
        ));
  }
}
