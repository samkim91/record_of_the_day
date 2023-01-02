part of 'wod_create_bloc.dart';

class WodCreateState extends Equatable {
  final WodType wodType;
  final String wodTypeSub;
  final ParticipationType participationType;
  final int memberCount;
  final List<String> wodDetails;

  const WodCreateState({this.wodType = WodType.amrap,
    this.wodTypeSub = '',
    this.participationType = ParticipationType.individual,
    this.memberCount = 0,
    this.wodDetails = const <String>[]});

  @override
  List<Object> get props =>
      [wodType, wodTypeSub, participationType, memberCount, wodDetails];

  WodCreateState copyWith(
      {WodType? wodType, String? wodTypeSub, ParticipationType? participationType, int? memberCount, List<
          String>? wodDetails}) {
    return WodCreateState(
      wodType: wodType ?? this.wodType,
      wodTypeSub: wodTypeSub ?? this.wodTypeSub,
      participationType: participationType ?? this.participationType,
      memberCount: memberCount ?? this.memberCount,
      wodDetails: wodDetails ?? this.wodDetails,
    );
  }
}
