import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/makearoom/makearoom.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'bloc/bloc.dart';

class MakeARoomScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String _tipe;
  MakeARoomScreen(
      {Key key, @required UserRepository userRepository, @required String tipe})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _tipe = tipe,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: BlocProvider<MakeARoomBloc>(
          builder: (context) => MakeARoomBloc(),
          child: MakeARoom(
            tipe: _tipe,
            userRepository: _userRepository,
          ),
        ));
  }
}
