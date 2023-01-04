part of 'wod_create_bloc.dart';

class WodCreateState extends Equatable {
  final WodType wodType;
  final String wodTypeSub;
  final bool isValidWodTypeSub;
  final ParticipationType participationType;
  final int memberCount;
  final List<String> wodDetails;
  final bool isValidWodDetails;
  final String wodDetail;

  const WodCreateState({
    this.wodType = WodType.amrap,
    this.wodTypeSub = '',
    this.isValidWodTypeSub = true,
    this.participationType = ParticipationType.individual,
    this.memberCount = 0,
    this.wodDetails = const <String>[],
    this.isValidWodDetails = true,
    this.wodDetail = '',
  });

  @override
  List<Object> get props => [
        wodType,
        wodTypeSub,
        isValidWodTypeSub,
        participationType,
        memberCount,
        wodDetails,
        isValidWodDetails,
        wodDetail,
      ];

  WodCreateState copyWith({
    WodType? wodType,
    String? wodTypeSub,
    bool? isValidWodTypeSub,
    ParticipationType? participationType,
    int? memberCount,
    List<String>? wodDetails,
    bool? isValidWodDetails,
    String? wodDetail,
  }) {
    return WodCreateState(
      wodType: wodType ?? this.wodType,
      wodTypeSub: wodTypeSub ?? this.wodTypeSub,
      isValidWodTypeSub: isValidWodTypeSub ?? this.isValidWodTypeSub,
      participationType: participationType ?? this.participationType,
      memberCount: memberCount ?? this.memberCount,
      wodDetails: wodDetails ?? this.wodDetails,
      isValidWodDetails: isValidWodDetails ?? this.isValidWodDetails,
      wodDetail: wodDetail ?? this.wodDetail,
    );
  }
}
