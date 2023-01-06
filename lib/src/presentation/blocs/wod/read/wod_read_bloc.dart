import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/domain/repositories/wod_repository.dart';

part 'wod_read_event.dart';

part 'wod_read_state.dart';

class WodReadBloc extends Bloc<WodReadEvent, WodReadState> {
  final WodRepository _wodRepository;

  WodReadBloc(this._wodRepository) : super(const WodReadState()) {
    on<WodReadEvent>((event, emit) {

    });
  }
}
