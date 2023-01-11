import '../../data/models/record.dart';

abstract class RecordRepository {
  Future<List<Record>> readRecords(String wodId);

  Future<void> createRecord(String wodId, Record record);

  Future<void> updateRecord(String wodId, Record record);
}
