import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/domain/entities/wod_type.dart';

class Wod extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final WodType type;
  final String typeDetail;
  final ParticipationType participationType;
  final int memberCount;
  final List<String> movements;
  final bool isActive;

  // TODO: 2023/01/05 records

  const Wod({
    this.id,
    this.createdAt,
    this.type = WodType.amrap,
    this.typeDetail = "",
    this.participationType = ParticipationType.individual,
    this.memberCount = 0,
    this.movements = const <String>[],
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        type,
        typeDetail,
        participationType,
        memberCount,
        movements,
        isActive,
      ];

  Wod copyWith({
    String? id,
    DateTime? createdAt,
    WodType? type,
    String? typeDetail,
    ParticipationType? participationType,
    int? memberCount,
    List<String>? movements,
    bool? isActive,
  }) {
    return Wod(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      typeDetail: typeDetail ?? this.typeDetail,
      participationType: participationType ?? this.participationType,
      memberCount: memberCount ?? this.memberCount,
      movements: movements ?? this.movements,
      isActive: isActive ?? this.isActive,
    );
  }

  factory Wod.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Wod(
      id: snapshot.id,
      createdAt: data?["createdAt"].toDate(),
      type: data?["type"] != null
          ? WodType.values
              .firstWhere((element) => element.text == data?["type"])
          : WodType.custom,
      typeDetail: data?["typeDetail"],
      participationType: data?["participationType"] != null
          ? ParticipationType.values.firstWhere(
              (element) => element.text == data?["participationType"])
          : ParticipationType.individual,
      memberCount: data?["memberCount"],
      movements: data?["movements"] is Iterable
          ? List.from(data?["movements"])
          : <String>[],
      isActive: data?["isActive"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "createdAt": FieldValue.serverTimestamp(),
      "type": type.text,
      "typeDetail": typeDetail,
      "participationType": participationType.text,
      "memberCount": memberCount,
      "movements": movements,
      "isActive": isActive,
    };
  }
}
