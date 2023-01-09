import 'dart:async';

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
    on<GetWods>(_getWods);
  }

  FutureOr<void> _getWods(GetWods event, Emitter<WodListState> emit) async {
    logger.d("_getWods: ");
    try {
      emit(state.copyWith(status: NetworkStatus.processing));

      final wods = await _wodRepository.readWods();

      List<Wod> addedWods = List.from(state.wods)..addAll(wods);

      emit(state.copyWith(wods: addedWods, status: NetworkStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.error, error: e.toString()));
    }
  }
}
