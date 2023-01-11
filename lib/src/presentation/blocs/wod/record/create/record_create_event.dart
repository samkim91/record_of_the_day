part of 'record_create_bloc.dart';

@immutable
abstract class RecordCreateEvent extends Equatable {}

class InitializeRecord extends RecordCreateEvent {
  final String wodId;
  final Record? record;

  InitializeRecord(this.wodId, this.record);

  @override
  List<Object?> get props => [wodId, record];
}

class TypeResult extends RecordCreateEvent {
  final String result;

  TypeResult(this.result);

  @override
  List<Object?> get props => [result];
}

class TypeMemo extends RecordCreateEvent {
  final String memo;

  TypeMemo(this.memo);

  @override
  List<Object?> get props => [memo];
}

class SaveRecord extends RecordCreateEvent {
  final String wodId;
  final Record? record;

  SaveRecord(this.wodId, this.record);

  @override
  List<Object?> get props => [wodId, record];
}
