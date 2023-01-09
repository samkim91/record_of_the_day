import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/domain/repositories/wod_repository.dart';

part 'wod_list_event.dart';
part 'wod_list_state.dart';

class WodListBloc extends Bloc<WodListEvent, WodListState> {
  final WodRepository _wodRepository;

  WodListBloc(this._wodRepository) : super(const WodListState()) {
    on<InitializeWods>(_initializeWods);
    on<GetWods>(_getWods);
  }

  FutureOr<void> _initializeWods(
      InitializeWods event, Emitter<WodListState> emit) {
    logger.d("_initializeWods: ");
    const wodListState = WodListState();
    emit(wodListState);
  }

  FutureOr<void> _getWods(GetWods event, Emitter<WodListState> emit) async {
    logger.d("_getWods: ");
    try {
      emit(state.copyWith(status: NetworkStatus.processing));

      Wod? lastWod = state.wods.lastOrNull;

      final wods = await _wodRepository.readWods(lastWod, state.pageSize);

      if (wods.last == lastWod) {
        emit(state.copyWith(isMoreData: false, status: NetworkStatus.success));

        return Future.sync(() => null);
      }

      List<Wod> addedWods = List.from(state.wods)..addAll(wods);

      emit(state.copyWith(wods: addedWods, status: NetworkStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.error, error: e.toString()));
    }
  }
}