part of 'record_create_bloc.dart';

@immutable
class RecordCreateState extends Equatable {
  final NetworkStatus status;
  final String error;

  final String wodId;
  final Record record;
  final bool isValidResult;

  const RecordCreateState({
    this.status = NetworkStatus.initial,
    this.error = "",
    this.wodId = "",
    this.record = const Record(),
    this.isValidResult = true,
  });

  @override
  List<Object?> get props => [status, error, wodId, record, isValidResult];

  RecordCreateState copyWith({
    NetworkStatus? status,
    String? error,
    String? wodId,
    Record? record,
    bool? isValidResult,
  }) {
    return RecordCreateState(
      status: status ?? this.status,
      error: error ?? this.error,
      wodId: wodId ?? this.wodId,
      record: record ?? this.record,
      isValidResult: isValidResult ?? this.isValidResult,
    );
  }
}
