import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? _userId;
  bool? _authState;
  String? get userId => _userId;
  bool? get authState => _authState;

  void setAuthState(bool value) {
    _authState = value;
  }

  setUserId(uid) {
    _userId = uid;
    notifyListeners();
  }

  Future login(email, password) async {
    try {
      var userCred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCred.user;
      setUserId(user?.uid);
      setAuthState(true);
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future signOut() async {
    await auth.signOut();
    setUserId(null);
    setAuthState(false);
  }

  Future deleteAccount() async {
    await auth.currentUser?.delete();
    setUserId(null);
    setAuthState(false);
  }

  Future<User?> register(email, password) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      setUserId(user?.uid);
      setAuthState(true);
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  void getAuthState() {
    var currentUser = auth.currentUser;
    if (currentUser == null) {
      setAuthState(false);
      setUserId(null);
    } else {
      setAuthState(true);
      setUserId(currentUser.uid);
    }
  }
}
