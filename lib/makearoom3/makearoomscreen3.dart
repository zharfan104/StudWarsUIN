import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/makearoom/makearoom.dart';
import 'package:flutter_firebase_login/makearoom3/makearoom3.dart';
import 'package:flutter_firebase_login/user_repository.dart';

import 'bloc/bloc.dart';

class MakeARoomScreen3 extends StatelessWidget {
  final UserRepository _userRepository;
  final String _tipe;
  MakeARoomScreen3(
      {Key key, @required UserRepository userRepository, @required String tipe})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _tipe = tipe,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: BlocProvider<MakeARoomBloc3>(
          builder: (context) => MakeARoomBloc3(),
          child: MakeARoom3(
            tipe: _tipe,
            userRepository: _userRepository,
          ),
        ));
  }
}
