import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/services/db_filestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFireStoreService implements DbApi {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _collectionJournals = 'journals';

  DbFireStoreService() {
    _firestore.settings;
  }

  @override
  Stream<List<Journal>> getJournalList(String uid) {
    return _firestore
        .collection(_collectionJournals)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
            List<Journal> journalDocs = snapshot.docs.map((doc) {
              return Journal.fromDoc(doc);
            }).toList();

            journalDocs.sort((doc1, doc2) => doc2.date.compareTo(doc1.date));
            return journalDocs;
        });
  }

  @override
  Future<bool> addJournal(Journal journal) async {
    DocumentReference documentReference = await _firestore
        .collection(_collectionJournals)
        .add({
          'date': journal.date,
          'mood': journal.mood,
          'note': journal.note,
          'uid': journal.uid,
        });
    return documentReference?.id != null;
  }
  
  @override
  void updateJournal(Journal journal) async {
    await _firestore
        .collection(_collectionJournals)
        .doc(journal.documentID)
        .update({
          'date': journal.date,
          'mood': journal.mood,
          'note': journal.note,
        })
        .catchError((error) => debugPrint('Error updating: $error'));
  }

  @override
  void deleteJournal(Journal journal) async {
    // TODO: implement deleteJournal
    await _firestore
        .collection(_collectionJournals)
        .doc(journal.documentID)
        .delete()
        .catchError((error) => debugPrint('Error deleting: $error'));
  }
}