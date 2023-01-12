import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/core/config/network.dart';

import '../../../../../core/config/logger.dart';
import '../../../../../data/models/record.dart';
import '../../../../../domain/repositories/record_repository.dart';

part 'record_create_event.dart';
part 'record_create_state.dart';

class RecordCreateBloc extends Bloc<RecordCreateEvent, RecordCreateState> {
  final RecordRepository _recordRepository;

  RecordCreateBloc(this._recordRepository) : super(const RecordCreateState()) {
    on<InitializeRecord>(_onInitializeRecord);
    on<TypeResult>(_onChangeResult);
    on<TypeMemo>(_onChangeMemo);

    on<SaveRecord>(_onSaveRecord);
  }

  FutureOr<void> _onInitializeRecord(
      InitializeRecord event, Emitter<RecordCreateState> emit) {
    logger.d("_onInitializeRecord: ");
    emit(state.copyWith(wodId: event.wodId, record: event.record));
  }

  FutureOr<void> _onChangeResult(
      TypeResult event, Emitter<RecordCreateState> emit) {
    logger.d("_onChangeResult: ");

    final Record updatedRecord = state.record.copyWith(result: event.result);

    emit(state.copyWith(record: updatedRecord));
  }

  FutureOr<void> _onChangeMemo(
      TypeMemo event, Emitter<RecordCreateState> emit) {
    logger.d("_onChangeMemo: ");

    final Record updatedRecord = state.record.copyWith(memo: event.memo);

    emit(state.copyWith(record: updatedRecord));
  }

  FutureOr<void> _onSaveRecord(
      SaveRecord event, Emitter<RecordCreateState> emit) async {
    logger.d("_onSaveRecord: ");

    // Validation
    if (state.record.result.isEmpty) {
      emit(state.copyWith(isValidResult: state.record.result.isNotEmpty));

      return Future(() => null);
    }

    final Record updatedRecord = event.record == null
        ? state.record
            .copyWith(result: state.record.result, memo: state.record.memo)
        : event.record!
            .copyWith(result: state.record.result, memo: state.record.memo);

    try {
      updatedRecord.id == null
          ? await _recordRepository.createRecord(event.wodId, updatedRecord)
          : await _recordRepository.updateRecord(event.wodId, updatedRecord);

      emit(state.copyWith(status: NetworkStatus.success));
    } catch (e) {
      logger.e("${e.toString()}");
      emit(state.copyWith(status: NetworkStatus.error, error: e.toString()));
    }
  }
}
