import 'package:flutter_firebase_login/user.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final User user;
  factory ProfileState.empty() {
    return ProfileState(
        user: User(
            email: "Loading..",
            nama: "Loading..",
            picurl:
                "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png",
            badges: "Loading..",
            poin: 0,
            kalah: 0,
            menang: 0,
            sekolah: "(Ganti Sekolah di Pengaturan)",
            level: "Loading.."));
  }
  ProfileState({this.user});
  @override
  String toString() {
    return '''ProfileState {
      user: ${user.email},
    }''';
  }
}
