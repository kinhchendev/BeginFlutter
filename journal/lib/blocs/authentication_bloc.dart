import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:journal/services/authentication_api.dart';

class AuthenticationBloc {
  late final AuthenticationApi authenticationApi;
  final StreamController<String> _authenticationController = StreamController<String>();
  Sink<String?> get addUser => _authenticationController.sink;
  Stream<String> get user => _authenticationController.stream;

  final StreamController<bool> _logoutController = StreamController<bool>();
  Sink<bool> get logoutUser => _logoutController.sink;
  Stream<bool> get listLogoutUser => _logoutController.stream;

  AuthenticationBloc(this.authenticationApi) {
    onAuthChanged();
  }

  void dispose() {
    _authenticationController.close();
    _logoutController.close();
  }

  void onAuthChanged() {
    authenticationApi.getFirebaseAuth()
        .authStateChanges()
        .listen((user) {
          final String? uid = (user?.uid);
          debugPrint('authentication_bloc onAuthChanged user=$user');
          if (uid != null) {
            addUser.add(uid);
          } else {
            addUser.add('');
          }
    });
    _logoutController.stream.listen((logout) {
      if (logout == true) {
        _signOut();
      }
    });
  }

  void _signOut() {
    debugPrint('_signOut');
    authenticationApi.signOut();
  }
}