import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journal/services/authentication_api.dart';
import 'package:journal/services/db_filestore_api.dart';
import 'package:journal/models/journal.dart';

class HomeBloc {
  final DbApi dbApi;
  final AuthenticationApi authenticationApi;
  final StreamController<List<Journal>> _journalController =
      StreamController<List<Journal>>.broadcast();
  Sink<List<Journal>> get _addListJournal => _journalController.sink;
  Stream<List<Journal>> get listJournal => _journalController.stream;
  final StreamController<Journal> _journalDeleteController =
      StreamController<Journal>.broadcast();
  Sink<Journal> get deleteJournal => _journalDeleteController.sink;
  HomeBloc(this.dbApi, this.authenticationApi) {
    debugPrint('HomeBloc constructor');
    if (this.dbApi == null) {
      debugPrint('dbApi == null');
    }
    if (this.authenticationApi == null) {
      debugPrint('authenticationApi == null');
    }
    _startListeners();
  }

  void dispose() {
    _journalController.close();
    _journalDeleteController.close();
  }

  void _startListeners() {
    // Retrieve Firestore Journal Records as List<Journal> not DocumentSnapshot
    debugPrint('HomeBloc startListeners');
    User? user = authenticationApi.getFirebaseAuth().currentUser;
    debugPrint('HomeBloc user = $user');
    dbApi.getJournalList(user!.uid).listen((journalDocs) {
      debugPrint('HomeBloc getJournalList response journalDocs = $journalDocs');
      _addListJournal.add(journalDocs);
    });

    _journalDeleteController.stream.listen((journal) {
      dbApi.deleteJournal(journal);
    });
  }
}
