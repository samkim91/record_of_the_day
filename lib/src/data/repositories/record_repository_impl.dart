import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:way_to_fit/src/domain/repositories/record_repository.dart';

import '../../core/config/network.dart';
import '../models/record.dart';

class RecordRepositoryImpl implements RecordRepository {
  @override
  Future<void> createRecord(String wodId, Record record) async {
    final recordCollection = firestore
        .collection(Collections.wods.name)
        .doc(wodId)
        .collection(Collections.records.name)
        .withConverter(
            fromFirestore: Record.fromFirestore,
            toFirestore: (Record record, options) => record.toFirestore());

    await recordCollection.add(record);
  }

  @override
  Future<List<Record>> readRecords(String wodId) async {
    final recordCollection = firestore
        .collection(Collections.wods.name)
        .doc(wodId)
        .collection(Collections.records.name)
        .withConverter(
            fromFirestore: Record.fromFirestore,
            toFirestore: (Record record, options) => record.toFirestore());

    final querySnap = await recordCollection.get();

    return querySnap.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> updateRecord(String wodId, Record record) async {
    final recordCollection = firestore
        .collection(Collections.wods.name)
        .doc(wodId)
        .collection(Collections.records.name)
        .withConverter(
            fromFirestore: Record.fromFirestore,
            toFirestore: (Record record, options) => record.toFirestore());

    recordCollection.doc(record.id).set(record, SetOptions(merge: true));
  }
}
