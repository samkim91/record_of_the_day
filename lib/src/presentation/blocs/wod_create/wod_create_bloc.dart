import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';

import '../../../core/config/logger.dart';
import '../../../domain/entities/wod_type.dart';

part 'wod_create_event.dart';
part 'wod_create_state.dart';

class WodCreateBloc extends Bloc<WodCreateEvent, WodCreateState> {
  WodCreateBloc() : super(const WodCreateState()) {
    on<SelectWodType>(_wodTypeChanged);
    on<TypeWodTypeSub>(_wodTypeSubChanged);
    on<SelectParticipationType>(_participationTypeSelected);
    on<TypeMemberCount>(_memberCountChanged);
    on<TypeWodDetail>(_wodDetailChanged);
    on<AddWodDetail>(_wodDetailAdded);
    on<ClickDeleteWodDetail>(_wodDetailDeleted);
  }

  FutureOr<void> _wodTypeChanged(
      SelectWodType event, Emitter<WodCreateState> emit) async {
    logger.d('_wodTypeChanged ${event.wodType}');

    emit(state.copyWith(wodType: event.wodType));
  }

  FutureOr<void> _wodTypeSubChanged(
      TypeWodTypeSub event, Emitter<WodCreateState> emit) {
    logger.d('_wodTypeSubChanged ${event.wodTypeSub}');

    emit(state.copyWith(wodTypeSub: event.wodTypeSub));
  }

  FutureOr<void> _participationTypeSelected(
      SelectParticipationType event, Emitter<WodCreateState> emit) {
    logger.d('_participationTypeSelected: ${event.participationType}');

    emit(state.copyWith(participationType: event.participationType));
  }

  FutureOr<void> _memberCountChanged(
      TypeMemberCount event, Emitter<WodCreateState> emit) {
    logger.d('_participationTypeSelected: ${event.memberCount}');

    emit(state.copyWith(memberCount: event.memberCount));
  }

  FutureOr<void> _wodDetailChanged(
      TypeWodDetail event, Emitter<WodCreateState> emit) {
    logger.d('_wodDetailChanged: ${event.wodDetail}');

    emit(state.copyWith(wodDetail: event.wodDetail));
  }

  FutureOr<void> _wodDetailAdded(
      AddWodDetail event, Emitter<WodCreateState> emit) {
    logger.d('_wodDetailAdded: ${event.wodDetail}');

    List<String> wodDetails = List.from(state.wodDetails)..add(event.wodDetail);

    emit(state.copyWith(wodDetails: wodDetails));
  }

  FutureOr<void> _wodDetailDeleted(
      ClickDeleteWodDetail event, Emitter<WodCreateState> emit) {
    logger.d('_wodDetailDeleted: ${event.index}');

    List<String> wodDetails = List.from(state.wodDetails)
      ..removeAt(event.index);

    emit(state.copyWith(wodDetails: wodDetails));
  }
}
