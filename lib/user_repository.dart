import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_login/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("Masuk1");

    print("Masuk2");
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    print("Masuk2");

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      print("Bang");
    }

    print(googleAuth.accessToken);
    print(googleAuth.idToken);

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    var email = (await _firebaseAuth.currentUser()).email;

    final FirebaseUser user =
        (await _firebaseAuth.signInWithCredential(credential)).user;

    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("user")
          .where("email", isEqualTo: user.email)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.isEmpty) {
        Firestore.instance.collection('user').document(email).setData({
          "email": user.email,
          "picurl": user.photoUrl,
          "nama": user.displayName,
          "menang": 0,
          "kalah": 0,
          "Sekolah": "",
          "id": user.uid,
          "poin": 0,
          "level": "1",
          "playwith": "null",
        });
        prefs.setInt('menang', 0);
        prefs.setInt('kalah', 0);
        prefs.setInt('poin', 0);
        prefs.setString('level', "1");
        prefs.setString('Sekolah', "Buka Pengaturan");
      } else {
        final documents = await Firestore.instance
            .collection('user')
            .where("email", isEqualTo: user.email)
            .getDocuments();
        final userObject = documents.documents.first.data;
        prefs.setInt('menang', userObject["menang"]);
        prefs.setInt('kalah', userObject["kalah"]);
        prefs.setInt('poin', userObject["poin"]);
        prefs.setString('level', userObject["level"]);
        prefs.setString('Sekolah', userObject["sekolah"] ?? "Buka Pengaturan");
        print(documents);
      }
      prefs.setString('email', user.email);
      prefs.setString('picurl', user.photoUrl);
      prefs.setString('nama', user.displayName);
      prefs.setString('id', user.uid);
    }

    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    var email = (await _firebaseAuth.currentUser()).email;
    return email;
  }

  Future<User> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var email = (await _firebaseAuth.currentUser()).email;
    var nama = prefs.getString('nama');
    var menang = prefs.getInt('menang');
    var kalah = prefs.getInt('kalah');
    var poin = prefs.getInt('poin');
    var level = prefs.getString('level');
    var sekolah = prefs.getString('sekolah');
    var picurl = prefs.getString('picurl');

    final User _user = new User(
        email: email,
        kalah: kalah,
        menang: menang,
        nama: nama,
        picurl: picurl,
        level: level,
        poin: poin,
        sekolah: sekolah);
    print(_user.badges);
    return _user;
  }
}
