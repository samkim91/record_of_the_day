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

class TypeWodTypeDetail extends WodCreateEvent {
  final String wodTypeSub;

  const TypeWodTypeDetail(this.wodTypeSub);

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

class TypeWodMovement extends WodCreateEvent {
  final String wodDetail;

  const TypeWodMovement(this.wodDetail);

  @override
  List<Object> get props => [wodDetail];
}

class AddWodMovement extends WodCreateEvent {
  final String wodDetail;

  const AddWodMovement(this.wodDetail);

  @override
  List<Object> get props => [wodDetail];
}

class ClickDeleteWodMovement extends WodCreateEvent {
  final int index;

  const ClickDeleteWodMovement(this.index);

  @override
  List<Object> get props => [index];
}

class TypeInstructions extends WodCreateEvent {
  final String instructions;

  const TypeInstructions(this.instructions);

  @override
  List<Object> get props => [instructions];
}

class SaveWod extends WodCreateEvent {
  const SaveWod();
}
