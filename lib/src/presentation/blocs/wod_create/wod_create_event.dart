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
  const TypeWodTypeSub();
}

class SelectParticipationType extends WodCreateEvent {
  final ParticipationType participationType;

  const SelectParticipationType(this.participationType);
}

class TypeMemberCount extends WodCreateEvent {
  const TypeMemberCount();
}

class ClickAddWodDetail extends WodCreateEvent {
  // todo detail 추가

  const ClickAddWodDetail();
}

class ClickDeleteWodDetail extends WodCreateEvent {
  const ClickDeleteWodDetail();
}

class CreateWod extends WodCreateEvent {
  const CreateWod();
}
