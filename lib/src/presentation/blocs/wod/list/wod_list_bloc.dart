import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/logger.dart';
import '../../../../core/config/network.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../data/models/wod.dart';
import '../../../../domain/repositories/wod_repository.dart';

part 'wod_list_event.dart';
part 'wod_list_state.dart';

class WodListBloc extends Bloc<WodListEvent, WodListState> {
  final WodRepository _wodRepository;

  WodListBloc(this._wodRepository) : super(const WodListState()) {
    on<InitializeWods>(_initializeWods);
    on<GetWods>(_getWods, transformer: debounce());
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
      Wod? lastWod = state.wods.lastOrNull;

      emit(state.copyWith(status: NetworkStatus.processing));

      final wods = await _wodRepository.readWods(lastWod, state.pageSize);

      if (wods.last == lastWod) {
        emit(state.copyWith(isMoreData: false, status: NetworkStatus.success));

        return Future.sync(() => null);
      }

      List<Wod> addedWods = List.from(state.wods)..addAll(wods);

      emit(state.copyWith(wods: addedWods, status: NetworkStatus.success));
    } catch (e) {
      logger.e("${e.toString()}");
      emit(state.copyWith(status: NetworkStatus.error, error: e.toString()));
    }
  }
}
