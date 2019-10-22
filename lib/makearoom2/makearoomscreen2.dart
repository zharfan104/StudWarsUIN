import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/makearoom2/makearoom2.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'bloc/bloc.dart';

class MakeARoomScreen2 extends StatelessWidget {
  final UserRepository _userRepository;
  final String _tipe;
  MakeARoomScreen2(
      {Key key, @required UserRepository userRepository, @required String tipe})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _tipe = tipe,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: BlocProvider<MakeARoomBloc2>(
          builder: (context) => MakeARoomBloc2(),
          child: MakeARoom2(
            tipe: _tipe,
            userRepository: _userRepository,
          ),
        ));
  }
}
