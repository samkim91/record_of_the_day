import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/presentation/screens/navigation.dart';

import '../../../core/config/logger.dart';
import '../../../domain/entities/wod_type.dart';

part 'wod_create_event.dart';
part 'wod_create_state.dart';

class WodCreateBloc extends Bloc<WodCreateEvent, WodCreateState> {
  WodCreateBloc() : super(const WodCreateState()) {
    on<SelectWodType>(_wodTypeChanged);
  }

  void _wodTypeChanged(SelectWodType event, Emitter<WodCreateState> emit) async {
    logger.d('_wodTypeChanged ${event.wodType}');

    emit(state.copyWith(wodType: event.wodType));
  }
}
