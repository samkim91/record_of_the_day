import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/logger.dart';
import '../../../../core/config/network.dart';
import '../../../../data/models/wod.dart';
import '../../../../domain/repositories/wod_repository.dart';

part 'wod_read_event.dart';
part 'wod_read_state.dart';

class WodReadBloc extends Bloc<WodReadEvent, WodReadState> {
  final WodRepository _wodRepository;

  WodReadBloc(this._wodRepository) : super(const WodReadState()) {
    on<GetWod>(_getWod);
  }

  Future<FutureOr<void>> _getWod(
      GetWod event, Emitter<WodReadState> emit) async {
    logger.d("_getWod: ${event.id}");

    try {
      emit(state.copyWith(status: NetworkStatus.processing));

      final Wod wod = await _wodRepository.readWod(event.id);

      emit(state.copyWith(wod: wod, status: NetworkStatus.success));
    } catch (e) {
      logger.e("_getWod: ${e.toString()}");
      emit(state.copyWith(status: NetworkStatus.error, error: e.toString()));
    }
  }
}
