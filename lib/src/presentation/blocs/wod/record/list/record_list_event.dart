part of 'record_list_bloc.dart';

@immutable
abstract class RecordListEvent extends Equatable {
  const RecordListEvent();

  @override
  List<Object> get props => [];
}

class InitializeRecords extends RecordListEvent {
  const InitializeRecords();
}

class GetRecords extends RecordListEvent {
  final String id;

  const GetRecords(this.id);
}
