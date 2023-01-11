import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/core/config/network.dart';

import '../../../../../core/config/logger.dart';
import '../../../../../data/models/record.dart';
import '../../../../../domain/repositories/record_repository.dart';

part 'record_list_event.dart';
part 'record_list_state.dart';

class RecordListBloc extends Bloc<RecordListEvent, RecordListState> {
  final RecordRepository _recordRepository;

  RecordListBloc(this._recordRepository) : super(const RecordListState()) {
    on<InitializeRecords>(_initializeRecords);
    on<GetRecords>(_getRecords);
  }

  FutureOr<void> _initializeRecords(
      InitializeRecords event, Emitter<RecordListState> emit) {
    logger.d("_initializeRecords: ");
  }

  Future<FutureOr<void>> _getRecords(
      GetRecords event, Emitter<RecordListState> emit) async {
    logger.d("_getRecords: ${event.id}");

    try {
      emit(state.copyWith(status: NetworkStatus.processing));

      final List<Record> records =
          await _recordRepository.readRecords(event.id);

      List<Record> addedRecords = List.from(state.records)..addAll(records);

      emit(
          state.copyWith(records: addedRecords, status: NetworkStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.error, error: e.toString()));
    }
  }
}