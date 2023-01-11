import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Record extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final String result;
  final String memo;

  // TODO: 2023/01/11 createdBy (User)

  const Record({this.id, this.createdAt, this.result = "", this.memo = ""});

  @override
  List<Object?> get props => [id, createdAt, result, memo];

  Record copyWith({
    String? id,
    DateTime? createdAt,
    String? result,
    String? memo,
  }) {
    return Record(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      result: result ?? this.result,
      memo: memo ?? this.memo,
    );
  }

  factory Record.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Record(
      id: snapshot.id,
      createdAt: data?["createdAt"].toDate(),
      result: data?["result"],
      memo: data?["memo"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "createdAt": FieldValue.serverTimestamp(),
      "result": result,
      "memo": memo,
    };
  }
}
