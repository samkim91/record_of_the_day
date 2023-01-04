part of 'wod_create_bloc.dart';

abstract class WodCreateEvent extends Equatable {
  const WodCreateEvent();

  @override
  List<Object> get props => [];
}

class SelectWodType extends WodCreateEvent {
  final WodType wodType;

  const SelectWodType(this.wodType);

  @override
  List<Object> get props => [wodType];
}

class TypeWodTypeSub extends WodCreateEvent {
  final String wodTypeSub;

  const TypeWodTypeSub(this.wodTypeSub);

  @override
  List<Object> get props => [wodTypeSub];
}

class SelectParticipationType extends WodCreateEvent {
  final ParticipationType participationType;

  const SelectParticipationType(this.participationType);

  @override
  List<Object> get props => [participationType];
}

class TypeMemberCount extends WodCreateEvent {
  final int memberCount;

  const TypeMemberCount(this.memberCount);

  @override
  List<Object> get props => [memberCount];
}

class TypeWodDetail extends WodCreateEvent {
  final String wodDetail;

  const TypeWodDetail(this.wodDetail);

  @override
  List<Object> get props => [wodDetail];
}

class AddWodDetail extends WodCreateEvent {
  final String wodDetail;

  const AddWodDetail(this.wodDetail);

  @override
  List<Object> get props => [wodDetail];
}

class ClickDeleteWodDetail extends WodCreateEvent {
  final int index;

  const ClickDeleteWodDetail(this.index);

  @override
  List<Object> get props => [index];
}

class SaveWod extends WodCreateEvent {
  const SaveWod();
}
