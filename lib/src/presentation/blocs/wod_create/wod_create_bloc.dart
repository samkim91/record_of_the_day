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
    on<AddWodDetail>(_wodDetailAdd);
    on<ClickDeleteWodDetail>(_wodDetailDelete);
    on<SaveWod>(_wodSave);
  }

  FutureOr<void> _wodTypeChanged(
      SelectWodType event, Emitter<WodCreateState> emit) async {
    logger.d('_wodTypeChanged ${event.wodType}');

    emit(state.copyWith(wodType: event.wodType));
  }

  FutureOr<void> _wodTypeSubChanged(
      TypeWodTypeSub event, Emitter<WodCreateState> emit) {
    final String wodTypeSub = event.wodTypeSub;
    logger.d('_wodTypeSubChanged $wodTypeSub');

    emit(state.copyWith(
        wodTypeSub: wodTypeSub, isValidWodTypeSub: wodTypeSub.isNotEmpty));
  }

  FutureOr<void> _participationTypeSelected(
      SelectParticipationType event, Emitter<WodCreateState> emit) {
    logger.d('_participationTypeSelected: ${event.participationType}');

    emit(state.copyWith(participationType: event.participationType));
  }

  FutureOr<void> _memberCountChanged(
      TypeMemberCount event, Emitter<WodCreateState> emit) {
    final int memberCount = event.memberCount;

    logger.d('_participationTypeSelected: $memberCount');

    emit(state.copyWith(memberCount: memberCount));
  }

  FutureOr<void> _wodDetailChanged(
      TypeWodDetail event, Emitter<WodCreateState> emit) {
    logger.d('_wodDetailChanged: ${event.wodDetail}');

    emit(state.copyWith(wodDetail: event.wodDetail));
  }

  FutureOr<void> _wodDetailAdd(
      AddWodDetail event, Emitter<WodCreateState> emit) {
    final String wodDetail = event.wodDetail;

    logger.d('_wodDetailAdded: $wodDetail');

    if (wodDetail.isEmpty) {
      return Future.sync(() => null);
    }

    List<String> wodDetails = List.from(state.wodDetails)..add(wodDetail);

    emit(state.copyWith(
        wodDetails: wodDetails, isValidWodDetails: wodDetails.isNotEmpty));
  }

  FutureOr<void> _wodDetailDelete(
      ClickDeleteWodDetail event, Emitter<WodCreateState> emit) {
    logger.d('_wodDetailDeleted: ${event.index}');

    List<String> wodDetails = List.from(state.wodDetails)
      ..removeAt(event.index);

    emit(state.copyWith(
        wodDetails: wodDetails, isValidWodDetails: wodDetails.isNotEmpty));
  }

  FutureOr<void> _wodSave(SaveWod event, Emitter<WodCreateState> emit) {
    logger.d('_wodCreate: ');

    // Validation
    if (state.wodTypeSub.isEmpty || state.wodDetails.isEmpty) {
      emit(state.copyWith(
          isValidWodTypeSub: state.wodTypeSub.isNotEmpty,
          isValidWodDetails: state.wodDetails.isNotEmpty));

      return Future.sync(() => null);
    }

    // TODO: 2023/01/04 save logic
  }
}
