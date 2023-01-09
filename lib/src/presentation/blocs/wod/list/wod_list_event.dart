part of 'wod_list_bloc.dart';

@immutable
abstract class WodListEvent extends Equatable {
  const WodListEvent();

  @override
  List<Object> get props => [];
}

class InitializeWods extends WodListEvent {
  const InitializeWods();
}

class GetWods extends WodListEvent {
  const GetWods();
}
