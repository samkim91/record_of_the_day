import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/domain/entities/rm_type.dart';
import 'package:way_to_fit/src/domain/entities/weight_type.dart';

class Rm extends Equatable {
  final String? id;
  final DateTime? measuredAt;
  final RmType type;
  final double result;
  final WeightType weightType;
  final String memo;

  const Rm({
    this.id,
    this.measuredAt,
    this.type = RmType.frontSquat,
    this.result = 0.0,
    this.weightType = WeightType.lb,
    this.memo = '',
  });

  @override
  List<Object?> get props => [id, measuredAt, type, result, weightType, memo];

  Rm copyWith({
     String? id,
     DateTime? measuredAt,
     RmType? type,
     double? result,
     WeightType? weightType,
     String? memo,
}) {
    return Rm(
      id: id ?? this.id,
      measuredAt: measuredAt ?? this.measuredAt,
      type: type ?? this.type,
      result: result ?? this.result,
      weightType: weightType ?? this.weightType,
      memo: memo ?? this.memo,
    );
  }

  factory Rm.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return Rm(
      id: snapshot.id,
      measuredAt: data?["measuredAt"].toDate(),
      type: data?["type"] != null ? RmType.values.firstWhere((element) => element.text == data?["type"]) : data?["type"],
      result: data?["result"],
      weightType: data?["weightType"] != null ? WeightType.values.firstWhere((element) => element == data?["weightType"]) : WeightType.lb,
      memo: data?["memo"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "measuredAt": FieldValue.serverTimestamp(),
      "type": type.text,
      "result": result,
      "weightType": weightType,
      "memo": memo,
    };
  }
}
