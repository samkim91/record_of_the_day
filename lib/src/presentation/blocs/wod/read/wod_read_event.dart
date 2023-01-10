part of 'wod_read_bloc.dart';

abstract class WodReadEvent extends Equatable {
  const WodReadEvent();

  @override
  List<Object> get props => [];
}

class GetWod extends WodReadEvent {
  final String id;

  const GetWod(this.id);
}

class ClickLikeWod extends WodReadEvent {
  const ClickLikeWod();
}

class DeleteWod extends WodReadEvent {
  const DeleteWod();
}
