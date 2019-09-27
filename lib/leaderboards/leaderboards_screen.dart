import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/leaderboards/bloc/bloc.dart';
import 'package:flutter_firebase_login/leaderboards/leaderboards.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LeaderboardBloc>(
        builder: (context) => LeaderboardBloc(),
        child: Leaderboard(),
      ),
    );
  }
}
