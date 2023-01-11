part of 'record_list_bloc.dart';

class RecordListState extends Equatable {
  final bool isMoreData;
  final int pageSize;

  final List<Record> records;
  final NetworkStatus status;
  final String error;

  const RecordListState(
      {this.isMoreData = true,
      this.pageSize = 100,
      this.records = const <Record>[],
      this.status = NetworkStatus.initial,
      this.error = ""});

  @override
  List<Object?> get props => [isMoreData, pageSize, records, status, error];

  RecordListState copyWith({
    bool? isMoreData,
    int? pageSize,
    List<Record>? records,
    NetworkStatus? status,
    String? error,
  }) {
    return RecordListState(
      isMoreData: isMoreData ?? this.isMoreData,
      pageSize: pageSize ?? this.pageSize,
      records: records ?? this.records,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
