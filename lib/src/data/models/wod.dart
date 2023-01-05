import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/domain/entities/wod_type.dart';

class Wod extends Equatable {
  final WodType type;
  final String typeDetail;
  final ParticipationType participationType;
  final int memberCount;
  final List<String> movements;

  // TODO: 2023/01/05 records

  const Wod({
    this.type = WodType.amrap,
    this.typeDetail = '',
    this.participationType = ParticipationType.individual,
    this.memberCount = 0,
    this.movements = const <String>[],
  });

  @override
  List<Object?> get props =>
      [type, typeDetail, participationType, memberCount, movements];

  Wod copyWith({
    WodType? type,
    String? typeDetail,
    ParticipationType? participationType,
    int? memberCount,
    List<String>? movements,
  }) {
    return Wod(
      type: type ?? this.type,
      typeDetail: typeDetail ?? this.typeDetail,
      participationType: participationType ?? this.participationType,
      memberCount: memberCount ?? this.memberCount,
      movements: movements ?? this.movements,
    );
  }

  factory Wod.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();
    return Wod(
      type: data?['type'],
      typeDetail: data?['typeDetail'],
      participationType: data?['participationType'],
      memberCount: data?['memberCount'],
      movements: data?['movements'] is Iterable
          ? List.from(data?['movements'])
          : <String>[],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "type": type,
      "typeDetail": typeDetail,
      "participationType": participationType,
      "memberCount": memberCount,
      "movements": movements,
    };
  }
}
